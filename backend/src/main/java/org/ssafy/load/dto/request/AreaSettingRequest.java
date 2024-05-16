package org.ssafy.load.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record AreaSettingRequest(
        @JsonProperty("area_id")
        int areaId,
        @JsonProperty("area_name")
        String areaName,
        @JsonProperty("convey_no")
        int conveyNo,
        int count
) {

}
