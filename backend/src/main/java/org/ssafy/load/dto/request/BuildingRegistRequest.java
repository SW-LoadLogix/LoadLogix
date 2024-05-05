package org.ssafy.load.dto.request;

public record BuildingRegistRequest (
    Long dongCode,
    String sidoName,
    String gugunName,
    String dongName,
    int zibunMain,
    int zibunSub,
    Long loadCode,
    int buildingMain,
    int buildingSub,
    int area_id
) {

}




