package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record LoadTaskResponse(
        @JsonProperty("task_id") Long taskId,
        LoadTaskCarResponse car,
        @JsonProperty("building_id_order") List<Integer> buildingIdOrder,
        List<LoadTaskGoodsResponse> goods
) {
}
