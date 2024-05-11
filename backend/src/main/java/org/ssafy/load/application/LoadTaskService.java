package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.common.type.BoxType;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.*;
import org.ssafy.load.dto.request.GoodsRequest;
import org.ssafy.load.dto.response.LoadStartResponse;
import org.ssafy.load.dto.request.ReadyRequest;

import java.util.List;
import java.util.Optional;

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
    public void setReadyCompletedArea(ReadyRequest readyRequest) {
        AreaEntity areaEntity = areaRepository.findById(readyRequest.areaId()).orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));

        LoadTaskEntity loadTaskEntity = loadTaskRepository.save(LoadTaskEntity.createNewEntity(readyRequest.count(), areaEntity));

        // 물품 저장
        for (GoodsRequest goods : readyRequest.goods()) {
            BoxTypeEntity boxType = boxTypeRepository.findByType(BoxType.valueOf("L" + goods.type()))
                    .orElseThrow(() -> new CommonException(ErrorCode.INVALID_DATA));
            BuildingEntity building = buildingRepository.findById(goods.buildingId() + 271)
                    .orElseThrow(() -> new CommonException(ErrorCode.INVALID_DATA));

            goodsRepository.save(GoodsEntity.createNewEntity(
                    goods.weight(),
                    goods.detailAddress(),
                    boxType,
                    building,
                    loadTaskEntity
            ));
        }
    }

    @Transactional
    public Boolean setReadyCompletedWorker(Long workerId) {
        WorkerEntity workerEntity = workerRepository.findById(workerId)
                .orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));

        AreaEntity areaEntity = workerEntity.getArea();
        int areaId = areaEntity.getId();
        int conveyNo = areaEntity.getConveyNo();
        List<LoadTaskEntity> loadTaskEntityList = loadTaskRepository.findByAlgorithmCompletedTask(areaId);
        if(loadTaskEntityList.isEmpty()) return false;

        LoadTaskEntity loadTaskEntity = loadTaskEntityList.get(0);
        loadTaskEntity.withUpdatedWorkerState(true);
        sseService.sendEvent("1", LoadStartResponse.of(areaId, conveyNo, true));
        return true;
    }
}

