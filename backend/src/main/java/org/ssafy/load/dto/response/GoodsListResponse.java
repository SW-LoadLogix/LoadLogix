package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record GoodsListResponse(
        @JsonProperty("area_name") String areaName,
        int total,
        List<BuildingDetailResponse> buildings
) {
}
