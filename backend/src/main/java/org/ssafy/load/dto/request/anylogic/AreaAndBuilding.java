package org.ssafy.load.dto.request.anylogic;

public record AreaAndBuilding(
    long buildingId,
    int areaId
) {
    public static AreaAndBuilding of(long buildingId, int areaId){
        return new AreaAndBuilding(buildingId,areaId);
    }
}
