package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.common.type.BoxType;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.dto.request.GoodsRequest;
import org.ssafy.load.dto.request.LoadStartRequest;
import org.ssafy.load.dto.request.ReadyRequest;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LoadTaskService {
    private final LoadTaskRepository loadTaskRepository;
    private final AreaRepository areaRepository;
    private final WorkerRepository workerRepository;
    private final BoxTypeRepository boxTypeRepository;
    private final BuildingRepository buildingRepository;
    private final GoodsRepository goodsRepository;
    private final SseService sseService;

    @Transactional
    public void setReadyCompletedArea(ReadyRequest readyRequest){
        areaRepository.findById(readyRequest.areaId()).ifPresentOrElse((areaEntity) -> {
            LoadTaskEntity loadTaskEntity = loadTaskRepository.save(
                            LoadTaskEntity.of(
                                    null,
                                    true,
                                    readyRequest.count(),
                                    false,
                                    false,
                                    null,
                                    areaEntity,
                                    null
                            ));

            // 물품 저장
            for(GoodsRequest goods : readyRequest.goods()){
                GoodsEntity goodsEntity = GoodsEntity.of(
                        null,
                        goods.weight(),
                        goods.detailAddress(),
                        0,
                        0,
                        0,
                        0,
                        boxTypeRepository.findByType(BoxType.valueOf("L"+goods.type())).orElseThrow(() -> new CommonException(ErrorCode.INVALID_DATA)),
                        buildingRepository.findById(goods.buildingId()).orElseThrow(() -> new CommonException(ErrorCode.INVALID_DATA)),
                        loadTaskEntity,
                        null
                );
                goodsRepository.save(goodsEntity);

            }

        }, () -> {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
        });
    }

    @Transactional
    public Boolean setReadyCompletedWorker(Long workerId) {

        return workerRepository.findById(workerId)
                .map(workerEntity -> {
                    AreaEntity areaEntity = workerEntity.getArea();
                    List<LoadTaskEntity> loadTaskEntities = areaEntity.getLoadTaskEntities();
                    for(LoadTaskEntity loadTaskEntity : loadTaskEntities){
                        if (loadTaskEntity != null || (!loadTaskEntity.getAreaStatus() && loadTaskEntity.getWorkerState() && loadTaskEntity.getComplete())) {
                            loadTaskRepository.save(loadTaskEntity.withUpdatedWorkerState(true));
                            sseService.sendEvent(LoadStartRequest.of(
                                    areaEntity.getId(),
                                    areaEntity.getConveyNo(),
                                    true
                            ));
                            return true;
                        }
                    }
                    return false;
                })
                .orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));
    }
}

