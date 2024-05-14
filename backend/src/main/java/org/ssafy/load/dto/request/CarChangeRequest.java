package org.ssafy.load.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CarChangeRequest(
        @JsonProperty("car_width")
        int carWidth,
        @JsonProperty("car_length")
        int carLength,
        @JsonProperty("car_height")
        int carHeight
) {
}
