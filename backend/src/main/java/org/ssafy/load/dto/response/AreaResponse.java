package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record AreaResponse(
        @JsonProperty("area_id")
        Integer areaId,
        @JsonProperty("area_name")
        String areaName,
        @JsonProperty("convey_no")
        int conveyNo,
        int count
) {
    public static AreaResponse of(Integer areaId, String areaName, int conveyNo, int count){
        return new AreaResponse(areaId, areaName,conveyNo,count);
    }
}
