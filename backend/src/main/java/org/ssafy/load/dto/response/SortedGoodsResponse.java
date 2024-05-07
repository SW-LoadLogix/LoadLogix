package org.ssafy.load.dto.response;

import org.ssafy.load.dto.Position;

public record SortedGoodsResponse(
    Long goodsId,
    String type,
    Position position,
    int weight,
    Long buildingId,
    String detailAddress
) {

}
