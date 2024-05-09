package org.ssafy.load.dto.request;

public record GoodsCreateRequest(
    int weight,
    String detailAddress,
    Long buildingId,
    int type
) {

}
