package org.ssafy.load.dto.response;

import org.ssafy.load.domain.WorkerEntity;

public record SignUpResponse(
    Long id,
    String userId,
    String name
) {

    public static SignUpResponse of(Long id, String userId, String name) {
        return new SignUpResponse(id, userId, name);
    }

    public static SignUpResponse from(WorkerEntity entity) {
        return SignUpResponse.of(
            entity.getId(),
            entity.getUserId(),
            entity.getName()
        );
    }
}
