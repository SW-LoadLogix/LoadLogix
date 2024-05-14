package org.ssafy.load.dto.response.goods;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.ssafy.load.dto.response.BuildingDetailResponse;

import java.util.List;

public record GoodsListResponse(
        @JsonProperty("area_name") String areaName,
        int total,
        List<BuildingDetailResponse> buildings
) {
}
