package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record AreaResponse(
        @JsonProperty("area_name")
        String areaName,
        @JsonProperty("convey_no")
        int conveyNo,
        int count
) {
    public static AreaResponse of(String areaName, int conveyNo, int count){
        return new AreaResponse(areaName,conveyNo,count);
    }
}
