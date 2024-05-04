package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AreaReadyStatusRepository;
import org.ssafy.load.dao.DeliveryAreaRepository;
import org.ssafy.load.domain.AreaReadyStatusEntity;
import org.ssafy.load.dto.AreaReadyStatus;
import org.ssafy.load.dto.request.ReadyAreaRequest;

@Service
@RequiredArgsConstructor
public class AreaReadyStatusService {
    private final AreaReadyStatusRepository areaReadyStatusRepository;
    private final DeliveryAreaRepository deliveryAreaRepository;

    @Transactional
    public void setReadyCompletedArea(ReadyAreaRequest readyAreaRequest){
        deliveryAreaRepository.findById(readyAreaRequest.areaId()).ifPresentOrElse((deliveryAreaEntity) -> {
            AreaReadyStatusEntity areaReadyStatusEntity = deliveryAreaEntity.getAreaReadyStatusEntity();

            AreaReadyStatus areaReadyStatus = AreaReadyStatus.from(areaReadyStatusEntity);

            if (areaReadyStatus.state()) {
                return;
            }

            areaReadyStatusEntity = areaReadyStatus.withUpdatedStateAndCount(true, readyAreaRequest.count())
                    .toEntity(deliveryAreaEntity);

            areaReadyStatusRepository.save(areaReadyStatusEntity);
        }, () -> {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
        });
    }

}
