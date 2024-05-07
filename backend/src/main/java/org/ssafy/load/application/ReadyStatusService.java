package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.dto.request.ReadyRequest;
import org.ssafy.load.dto.response.StatusResponse;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadyStatusService {
    private final LoadTaskRepository loadTaskRepository;
    private final AreaRepository areaRepository;
    private final WorkerRepository workerRepository;

    @Transactional
    public void setReadyCompletedArea(ReadyRequest readyAreaRequest){
        areaRepository.findById(readyAreaRequest.areaId()).ifPresentOrElse((areaEntity) -> {
            LoadTaskEntity readyStatusEntity = areaEntity.getLoadTask();

            if (readyStatusEntity == null) {
                throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
            }
            if (readyStatusEntity.getAreaStatus()) {
                return;
            }
            loadTaskRepository.save(
                    readyStatusEntity.withUpdatedAreaStateAndCount(true, readyAreaRequest.count()));
        }, () -> {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
        });
    }

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

