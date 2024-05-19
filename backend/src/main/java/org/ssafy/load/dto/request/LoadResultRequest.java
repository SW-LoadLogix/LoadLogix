package org.ssafy.load.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record LoadResultRequest(
        @JsonProperty("task_id") int taskId,
        List<LoadResultGoodsRequest> goods
) {
}
