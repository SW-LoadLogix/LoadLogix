package org.ssafy.load.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record BuildingRegistRequest (
    @JsonProperty("dong_code") Long dongCode,
    @JsonProperty("sido_name") String sidoName,
    @JsonProperty("gugun_name") String gugunName,
    @JsonProperty("dong_name") String dongName,
    @JsonProperty("zibun_main") int zibunMain,
    @JsonProperty("zibun_sub") int zibunSub,
    @JsonProperty("load_code") Long loadCode,
    @JsonProperty("building_main") int buildingMain,
    @JsonProperty("building_sub") int buildingSub,
    @JsonProperty("area_id") int areaId
) {

}




