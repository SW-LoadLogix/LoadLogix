package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.ReadyStatusRepository;
import org.ssafy.load.dao.DeliveryAreaRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.ReadyStatusEntity;
import org.ssafy.load.dto.request.ReadyAreaRequest;

@Service
@RequiredArgsConstructor
public class ReadyStatusService {
    private final ReadyStatusRepository readyStatusRepository;
    private final DeliveryAreaRepository deliveryAreaRepository;
    private final WorkerRepository workerRepository;

    @Transactional
    public void setReadyCompletedArea(ReadyAreaRequest readyAreaRequest){
        deliveryAreaRepository.findById(readyAreaRequest.areaId()).ifPresentOrElse((deliveryAreaEntity) -> {
            ReadyStatusEntity readyStatusEntity = deliveryAreaEntity.getReadyStatus();

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

    public boolean setReadyCompletedWorker(Long workerId) {
        return workerRepository.findById(workerId)
                .map(workerEntity -> {
                    ReadyStatusEntity readyStatusEntity = workerEntity.getDeliveryArea().getReadyStatus();
                    if (readyStatusEntity == null) {
                        throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
                    }
                    if (!readyStatusEntity.getWorkerState()) {
                        readyStatusRepository.save(readyStatusEntity.withUpdatedWorkerState(true));
                        return true;
                    }
                    return false;
                })
                .orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR));
    }
}
