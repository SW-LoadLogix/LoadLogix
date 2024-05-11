package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record PathResponse (
        @JsonProperty("building_id") long building_id,
        @JsonProperty("building_name") String building_name,
        double latitude,
        double longitude,
        @JsonProperty("total_goods") int totalGoods
){ }
