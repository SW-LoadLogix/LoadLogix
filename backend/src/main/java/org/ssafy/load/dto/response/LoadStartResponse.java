package org.ssafy.load.dto.response;

public record LoadStartResponse(
        int areaId,
        int conveyNo,
        boolean readyVehicle
) {
    public static LoadStartResponse of(
            int areaId,
            int conveyNo,
            boolean readyVehicle
    ){
        return new LoadStartResponse(areaId,conveyNo,readyVehicle);
    }
}
