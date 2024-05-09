package org.ssafy.load.dto.response;

import java.time.LocalDateTime;

public record GoodsOutputResponse(
    String areaName,
    String address,
    Long workerId,
    int weight,
    String boxType,
    LocalDateTime createdAt
) {

}
