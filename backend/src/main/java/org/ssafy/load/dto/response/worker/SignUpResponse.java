package org.ssafy.load.dto.response.worker;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.ssafy.load.domain.WorkerEntity;

public record SignUpResponse(
    Long id,
    @JsonProperty("user_id")
    String userId,
    String name
) {

    public static SignUpResponse of(Long id, String userId, String name) {
        return new SignUpResponse(id, userId, name);
    }

    public static SignUpResponse from(WorkerEntity entity) {
        return SignUpResponse.of(
            entity.getId(),
            entity.getLoginId(),
            entity.getName()
        );
    }
}
