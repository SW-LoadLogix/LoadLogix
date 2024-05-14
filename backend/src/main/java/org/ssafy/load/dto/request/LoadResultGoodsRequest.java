package org.ssafy.load.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoadResultGoodsRequest(
    @JsonProperty("goods_id") long goodsId,
    @JsonProperty("position") LoadResultPositionRequest loadResultPositionRequest
) {
}
