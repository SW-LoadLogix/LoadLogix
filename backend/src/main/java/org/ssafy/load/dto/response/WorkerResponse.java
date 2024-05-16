package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record WorkerResponse(
    String name,
    @JsonProperty("area_name")
    String areaName,
    @JsonProperty("total_count")
    int totalCount,
    boolean ready
) {

}
