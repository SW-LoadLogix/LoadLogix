package org.ssafy.load.dto.request;

import java.util.List;

public record ReadyRequest(
        int areaId,
        List<Long> agentIds
) {

}
