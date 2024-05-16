package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;

public record GoodsOutputResponse(
    @JsonProperty("area_name")
    String areaName,
    String address,
    @JsonProperty("worker_name")
    String workerName,
    int weight,
    @JsonProperty("box_type")
    String boxType,
    @JsonProperty("created_at")
    LocalDateTime createdAt
) {

}