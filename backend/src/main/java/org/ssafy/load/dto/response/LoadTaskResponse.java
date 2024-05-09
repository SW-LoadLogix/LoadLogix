package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record LoadTaskResponse(
        @JsonProperty("task_id") int taskId,
        LoadTaskCarResponse car,
        List<LoadTaskGoodsResponse> goods,
        @JsonProperty("building_id_order") List<Long> buildingIdOrder
) {
}
