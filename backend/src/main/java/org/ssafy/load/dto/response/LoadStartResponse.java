package org.ssafy.load.dto.response;

import java.util.List;

public record LoadStartResponse(
        int areaId,
        int conveyNo,
        boolean readyVehicle,
        List<Long> agentIds
) {
    public static LoadStartResponse of(
            int areaId,
            int conveyNo,
            boolean readyVehicle,
            List<Long> agentIds
    ){
        return new LoadStartResponse(areaId,conveyNo,readyVehicle, agentIds);
    }
}
