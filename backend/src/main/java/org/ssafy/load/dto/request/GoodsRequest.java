package org.ssafy.load.dto.request;

public record GoodsRequest(
        int id,
        int type,
        int areaId,
        long buildingId,
        String detailAddress,
        int weight
) {

}
