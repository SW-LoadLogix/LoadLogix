package org.ssafy.load.dto.request;

public record GoodsCreateRequest(
        long agentId,
        int weight,
        String detailAddress,
        Long buildingId,
        int type
) {

}
