package org.ssafy.load.dto.response;

import java.time.LocalDateTime;
import org.ssafy.load.domain.GoodsEntity;

public record CreateGoodsResponse(
    Long id,
    int weight,
    String detailAddress,
    LocalDateTime createAt,
    Long buildingId,
    int boxTypeId
) {

    public static CreateGoodsResponse from(GoodsEntity entity) {
        return new CreateGoodsResponse(
            entity.getId(),
            entity.getWeight(),
            entity.getDetailAddress(),
            entity.getCreatedAt(),
            entity.getBuilding().getId(),
            entity.getBoxType().getId());
    }
}
