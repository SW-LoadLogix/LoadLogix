package org.ssafy.load.dto;

import org.ssafy.load.domain.AreaReadyStatusEntity;
import org.ssafy.load.domain.DeliveryAreaEntity;
public record AreaReadyStatus(
        Integer id,
        boolean state,
        int count,
        DeliveryArea deliveryArea
) {
    public static AreaReadyStatus of(Integer id, boolean state, int count, DeliveryArea deliveryArea){
        return new AreaReadyStatus(id, state, count, deliveryArea);
    }

    public static AreaReadyStatus from(AreaReadyStatusEntity entity){
        return AreaReadyStatus.of(entity.getId(), entity.getState(), entity.getCount(), null);
    }

    public AreaReadyStatusEntity toEntity(DeliveryAreaEntity deliveryAreaEntity){
        return AreaReadyStatusEntity.of(this.id, this.state, this.count, deliveryAreaEntity);
    }

    public AreaReadyStatus withUpdatedStateAndCount(boolean newState, int newCount) {
        return new AreaReadyStatus(this.id, newState, newCount, this.deliveryArea);
    }
}
