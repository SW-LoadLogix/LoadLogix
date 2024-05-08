package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoadTaskCarResponse(
    int width,
    int height,
    int depth,
    @JsonProperty("max_weight") int maxWeight
) {
}
