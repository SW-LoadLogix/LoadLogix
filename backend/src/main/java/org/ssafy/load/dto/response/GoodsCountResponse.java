package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record GoodsCountResponse(
        @JsonProperty("total_count")
        long totalCount,
        @JsonProperty("store_count")
        long storeCount,
        @JsonProperty("load_count")
        long loadCount
) {

}
