package org.ssafy.load.dto;

import org.ssafy.load.domain.AreaReadyStatusEntity;
import org.ssafy.load.domain.DeliveryAreaEntity;

public record DeliveryArea(
        Integer id,
        String areaName,
        int conveyNo,
        AreaReadyStatus areaReadyStatus

) {
    public static DeliveryArea of(Integer id, String areaName, int conveyNo, AreaReadyStatus areaReadyStatus){
        return new DeliveryArea(id, areaName, conveyNo, areaReadyStatus);
    }

    public static DeliveryArea from(DeliveryAreaEntity entity){
        return DeliveryArea.of(
                entity.getId(),
                entity.getAreaName(),
                entity.getConveyNo(),
                AreaReadyStatus.from(entity.getAreaReadyStatusEntity())
        );
    }
    public DeliveryAreaEntity toEntity(AreaReadyStatusEntity areaReadyStatusEntity){
        return DeliveryAreaEntity.of(
                this.id,
                this.areaName,
                this.conveyNo,
                areaReadyStatusEntity
        );
    }

}
