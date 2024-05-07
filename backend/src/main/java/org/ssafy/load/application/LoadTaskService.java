package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.common.type.BoxType;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.dto.request.GoodsRequest;
import org.ssafy.load.dto.request.ReadyRequest;
import org.ssafy.load.dto.response.StatusResponse;

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

    @Transactional
    public void setReadyCompletedArea(ReadyRequest readyRequest){
        areaRepository.findById(readyRequest.areaId()).ifPresentOrElse((areaEntity) -> {
            LoadTaskEntity loadTaskEntity = areaEntity.getLoadTask();

            if (loadTaskEntity == null) {
                throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
            }
            if (loadTaskEntity.getAreaStatus()) {
                return;
            }
            loadTaskRepository.save(
                    loadTaskEntity.withUpdatedAreaStateAndCount(true, readyRequest.count()));

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

    // Todo 예지 : 알고리즘 완료 후 데이터 보내기 (로직 수정)
    @Transactional
    public StatusResponse setReadyCompletedWorker(Long workerId) {

        return workerRepository.findById(workerId)
                .map(workerEntity -> {
                    LoadTaskEntity readyStatusEntity = workerEntity.getArea().getLoadTask();
                    if (readyStatusEntity == null) {
                        throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
                    }
                    if(!readyStatusEntity.getAreaStatus()){
                        return StatusResponse.of(false, "Not Ready");
                    }
                    if (!readyStatusEntity.getWorkerState()) {
                        loadTaskRepository.save(readyStatusEntity.withUpdatedWorkerState(true));
                        return StatusResponse.of(false, "Loading Soon");
                    }
                    return StatusResponse.of(false, "Already Waiting");
                })
                .orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));
    }
    @Transactional
    public Integer getReadyStatus(){
        List<LoadTaskEntity> readyStatusEntityList = loadTaskRepository.findAll();
        for(LoadTaskEntity readyStatusEntity : readyStatusEntityList){

            if(readyStatusEntity.getAreaStatus() == true && readyStatusEntity.getWorkerState() == true){
                loadTaskRepository.save(readyStatusEntity.withUpdatedBothStatus(false, 0,false));
                return readyStatusEntity.getArea().getId();
            }
        }
        return 0;
    }
}

