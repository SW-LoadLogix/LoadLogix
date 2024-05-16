package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record RackStoreCountResponse(

        @JsonProperty("rack_line")
        int rackLine,
        @JsonProperty("total_count")
        long totalCount
) {

}
