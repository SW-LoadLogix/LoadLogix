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
import org.ssafy.load.dto.response.LoadStartResponse;
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
        System.out.println(readyRequest);
        areaRepository.findById(readyRequest.areaId()).ifPresentOrElse((areaEntity) -> {
            LoadTaskEntity loadTaskEntity = loadTaskRepository.save(
                            LoadTaskEntity.of(
                                    null,
                                    true,
                                    false,
                                    false,
                                    null,
                                    areaEntity,
                                    null
                            ));

            // agentid 찾아 load_task 튜플와 연결 (적재 준비 완료된 물품)
            for(long agentId : readyRequest.agentIds()){
                List<GoodsEntity> goodsList = goodsRepository.findAllByAgentId(agentId);
                for(GoodsEntity goods : goodsList){
                    goodsRepository.save(goods.updateLoadTaskId(loadTaskEntity));
                }
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
                    int areaId = areaEntity.getId();
                    int conveyNo = areaEntity.getConveyNo();
                    List<LoadTaskEntity> loadTaskEntities = loadTaskRepository.findAllByAreaIdOrderByCreatedAtDesc(areaId);
                    for(LoadTaskEntity loadTaskEntity : loadTaskEntities){
                        System.out.println(loadTaskEntity.getAreaStatus() +" "+loadTaskEntity.getWorkerState()+" "+loadTaskEntity.getComplete());

                        if (loadTaskEntity!=null && !loadTaskEntity.getWorkerState() && loadTaskEntity.getAreaStatus() && loadTaskEntity.getComplete()) {
                            loadTaskRepository.save(loadTaskEntity.withUpdatedWorkerState(true));
                            sseService.sendEvent("1", LoadStartResponse.of(
                                    areaId,
                                    conveyNo,
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

