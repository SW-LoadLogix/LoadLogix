package org.ssafy.load.dto.request;

public record LoadStartRequest(
        int areaId,
        int conveyNo,
        boolean readyVehicle
) {
    public static LoadStartRequest of(
            int areaId,
            int conveyNo,
            boolean readyVehicle
    ){
        return new LoadStartRequest(areaId,conveyNo,readyVehicle);
    }
}
