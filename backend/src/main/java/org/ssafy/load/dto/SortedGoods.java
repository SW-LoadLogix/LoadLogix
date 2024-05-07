package org.ssafy.load.dto;

public record SortedGoods(
    Long goodsId,
    String type,
    Position position,
    int weight,
    Long buildingId,
    String detailAddress
) {

}
