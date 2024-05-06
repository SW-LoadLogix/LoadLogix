package org.ssafy.load.dto.request;

import java.util.LinkedList;

public record ReadyRequest(
        int areaId,
        int count,
        LinkedList<GoodsRequest> goods
) {

}
