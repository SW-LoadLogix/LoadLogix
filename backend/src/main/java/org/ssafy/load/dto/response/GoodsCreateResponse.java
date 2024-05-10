package org.ssafy.load.dto.response;

import java.time.LocalDateTime;
import org.ssafy.load.domain.GoodsEntity;

public record GoodsCreateResponse(
    Long id,
    int weight,
    String detailAddress,
    LocalDateTime createAt,
    Long buildingId,
    int boxTypeId
) {

    public static GoodsCreateResponse from(GoodsEntity entity) {
        return new GoodsCreateResponse(
            entity.getId(),
            entity.getWeight(),
            entity.getDetailAddress(),
            entity.getCreatedAt(),
            entity.getBuilding().getId(),
            entity.getBoxType().getId());
    }
}
