package org.ssafy.load.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.JoinColumn;

public record GoodsRequest(
        int id,
        int type,
        int areaId,
        int buildingId,
        int detailAddress,
        int weight
) {

}
