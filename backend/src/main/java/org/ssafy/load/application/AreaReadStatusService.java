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
import org.ssafy.load.dto.response.ReadyAreaRequest;

@Service
@RequiredArgsConstructor
public class AreaReadStatusService {
    private final AreaReadyStatusRepository areaReadyStatusRepository;
    private final DeliveryAreaRepository deliveryAreaRepository;
    @Transactional
    public void setReadyCompletedArea(ReadyAreaRequest readyAreaRequest){
        deliveryAreaRepository.findById(readyAreaRequest.areaId()).ifPresentOrElse((deliveryAreaEntity)->{
            AreaReadyStatusEntity areaReadyStatusEntity = deliveryAreaEntity.getAreaReadyStatusEntity();
            AreaReadyStatus areaReadyStatus = AreaReadyStatus.from(areaReadyStatusEntity);
            if(areaReadyStatus.state()){
                // 예외처리 이미 대기 중
                return;
            }
            areaReadyStatusRepository.save(
                    areaReadyStatus.withStateAndCount(true, readyAreaRequest.count())
                            .toEntity()
            );

        }, () -> {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
        });
    }
}
