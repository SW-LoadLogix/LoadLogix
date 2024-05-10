package org.ssafy.load.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public record SortedGoods(
    @JsonProperty("goods_id") Long goodsId,
    @JsonProperty("type") String type,
    Position position,
    int weight,
    @JsonProperty("building_id") Long buildingId,
    @JsonProperty("building_name") String buildingName,
    @JsonProperty("detail_address") String detailAddress
) {

}
