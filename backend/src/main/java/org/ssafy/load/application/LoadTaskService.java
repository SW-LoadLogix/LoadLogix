package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.dao.GoodsRepository;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.dto.request.ReadyRequest;
import org.ssafy.load.dto.response.LoadStartResponse;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LoadTaskService {
    private final LoadTaskRepository loadTaskRepository;
    private final AreaRepository areaRepository;
    private final WorkerRepository workerRepository;
    private final GoodsRepository goodsRepository;
    private final SseService sseService;

    @Transactional
    public void setReadyCompletedArea(ReadyRequest readyRequest){
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
                    Optional<LoadTaskEntity> loadTaskEntityOptional  = loadTaskRepository.findFirstByAreaIdAndAreaStatusAndCompleteAndWorkerStateOrderByCreatedAtAsc(areaId, true, true, false);
                    if (loadTaskEntityOptional.isEmpty()) {
                        return false;
                    }
                    LoadTaskEntity loadTaskEntity = loadTaskEntityOptional.get();

                    // 관련 물품 얻기
                    List<GoodsEntity> goodsEntities =  loadTaskEntity.getGoodsEntities();
                    List<Long> agentIds = new ArrayList<>();
                    for(GoodsEntity goodsEntity: goodsEntities){
                        agentIds.add(goodsEntity.getAgentId());
                    }
                    loadTaskRepository.save(loadTaskEntity.withUpdatedWorkerState(true));
                    sseService.sendEvent("1", LoadStartResponse.of(
                            areaId,
                            conveyNo,
                            true,
                            agentIds
                    ));
                    return true;

                })
                .orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));
    }
}

