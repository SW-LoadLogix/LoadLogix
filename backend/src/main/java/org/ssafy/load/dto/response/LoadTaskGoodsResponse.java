package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoadTaskGoodsResponse(
        @JsonProperty("goods_id") int goodsId,
        String type,
        int weight,
        @JsonProperty("building_id") int buildingId
) {
}
