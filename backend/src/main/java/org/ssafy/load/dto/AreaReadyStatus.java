package org.ssafy.load.dto;

import org.ssafy.load.domain.AreaReadyStatusEntity;

public record AreaReadyStatus(
        Integer id,
        boolean state,
        int count,
        DeliveryArea deliveryArea
) {
    public static AreaReadyStatus of(Integer id, boolean state, int count, DeliveryArea deliveryArea){
        return new AreaReadyStatus(id ,state, count, deliveryArea);
    }
    public static AreaReadyStatus from(AreaReadyStatusEntity entity){
        return AreaReadyStatus.of(
                entity.getId(),
                entity.getState(),
                entity.getCount(),
                null
        );
    }

    public AreaReadyStatusEntity toEntity(){
        return AreaReadyStatusEntity.of(
                this.id,
                this.state,
                this.count,
                null
        );
    }
    public AreaReadyStatus withStateAndCount(boolean state, int count) {
        return AreaReadyStatus.of(this.id, state, count, this.deliveryArea);
    }
}

