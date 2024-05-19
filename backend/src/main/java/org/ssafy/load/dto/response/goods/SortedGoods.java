package org.ssafy.load.dto.response.goods;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.ssafy.load.dto.Position;

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
