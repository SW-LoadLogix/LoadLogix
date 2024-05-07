package org.ssafy.load.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoadTaskResponse(
        @JsonProperty("task_id") Long taskId
) {
}
