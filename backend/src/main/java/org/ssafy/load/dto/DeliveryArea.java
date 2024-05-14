package org.ssafy.load.dto;

import org.ssafy.load.domain.AreaEntity;

public record DeliveryArea(
        Integer id,
        String area_name
) {
    public static DeliveryArea of(Integer id, String area_name){
        return new DeliveryArea(id, area_name);
    }

    public static DeliveryArea from(AreaEntity entity){
        return DeliveryArea.of(
                entity.getId(),
                entity.getAreaName()
        );
    }

}
