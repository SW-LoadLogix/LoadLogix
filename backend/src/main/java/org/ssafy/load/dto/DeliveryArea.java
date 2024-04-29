package org.ssafy.load.dto;

import org.ssafy.load.domain.DeliveryAreaEntity;

public record DeliveryArea(
        Long id,
        String area_name
) {
    public static DeliveryArea of(Long id, String area_name){
        return new DeliveryArea(id, area_name);
    }

    public static DeliveryArea from(DeliveryAreaEntity entity){
        return DeliveryArea.of(
                entity.getId(),
                entity.getAreaName()
        );
    }

}
