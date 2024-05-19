package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record GoodsDetailResponse (
        @JsonProperty("goods_id") Long goodsId,
        @JsonProperty("box_type") String boxType,
        @JsonProperty("box_height") int box_height,
        @JsonProperty("box_length") int box_length,
        @JsonProperty("box_width") int box_width,
        int weight,
        @JsonProperty("detail_address") String detailAddress
) {
}

