package org.ssafy.load.dto.response;

import org.ssafy.load.domain.BuildingAddressEntity;

public record BuildingResponse(
        Long id,
        int buildingMain,
        int buildingSub
) {
    public static BuildingResponse of(
            Long id,
            int buildingMain,
            int buildingSub){
        return new BuildingResponse(id, buildingMain, buildingSub);
    }

    public static BuildingResponse fromBuilding (BuildingAddressEntity entity){
        return new BuildingResponse(entity.getId(), entity.getBuildingMain(), entity.getBuildingSub());
    }
}
