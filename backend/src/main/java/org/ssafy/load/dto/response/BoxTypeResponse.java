package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record BoxTypeResponse(
    Integer id,
    String type,
    int height,
    int length,
    int width,
    @JsonProperty("total_count")
    long totalCount
) {

}
