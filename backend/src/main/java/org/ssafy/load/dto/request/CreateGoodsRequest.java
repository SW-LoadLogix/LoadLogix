package org.ssafy.load.dto.request;

public record CreateGoodsRequest(
    int weight,
    String detailAddress,
    Long buildingId,
    int type
) {

}
