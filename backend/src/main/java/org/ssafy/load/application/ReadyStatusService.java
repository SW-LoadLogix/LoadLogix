package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.dao.ReadyStatusRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.ReadyStatusEntity;
import org.ssafy.load.dto.request.ReadyRequest;
import org.ssafy.load.dto.response.StatusResponse;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadyStatusService {
    private final ReadyStatusRepository readyStatusRepository;
    private final AreaRepository areaRepository;
    private final WorkerRepository workerRepository;

    @Transactional
    public void setReadyCompletedArea(ReadyRequest readyAreaRequest){
        areaRepository.findById(readyAreaRequest.areaId()).ifPresentOrElse((areaEntity) -> {
            ReadyStatusEntity readyStatusEntity = areaEntity.getReadyStatus();

            if (readyStatusEntity == null) {
                throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
            }
            if (readyStatusEntity.getAreaStatus()) {
                return;
            }
            readyStatusRepository.save(
                    readyStatusEntity.withUpdatedAreaStateAndCount(true, readyAreaRequest.count()));
        }, () -> {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
        });
    }

    @Transactional
    public StatusResponse setReadyCompletedWorker(Long workerId) {

        return workerRepository.findById(workerId)
                .map(workerEntity -> {
                    ReadyStatusEntity readyStatusEntity = workerEntity.getArea().getReadyStatus();
                    if (readyStatusEntity == null) {
                        throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
                    }
                    if(!readyStatusEntity.getAreaStatus()){
                        return StatusResponse.of(false, "Not Ready");
                    }
                    if (!readyStatusEntity.getWorkerState()) {
                        readyStatusRepository.save(readyStatusEntity.withUpdatedWorkerState(true));
                        return StatusResponse.of(false, "Loading Soon");
                    }
                    return StatusResponse.of(false, "Already Waiting");
                })
                .orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));
    }
    @Transactional
    public Integer getReadyStatus(){
        List<ReadyStatusEntity> readyStatusEntityList = readyStatusRepository.findAll();
        for(ReadyStatusEntity readyStatusEntity : readyStatusEntityList){

            if(readyStatusEntity.getAreaStatus() == true && readyStatusEntity.getWorkerState() == true){
                readyStatusRepository.save(readyStatusEntity.withUpdatedBothStatus(false, 0,false));
                return readyStatusEntity.getArea().getId();
            }
        }
        return 0;
    }
}

