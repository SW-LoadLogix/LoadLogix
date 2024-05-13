package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record BuildingDetailResponse (
        @JsonProperty("top_address") String topAddress,
        @JsonProperty("building_address") String buildingAddress,
        @JsonProperty("total_goods") int totalGoods,
        @JsonProperty("total_percentage") int totalPercentage,
        List<GoodsDetailResponse> goods
) {
}
