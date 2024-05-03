package org.ssafy.load.dto.response;

import org.ssafy.load.domain.WorkerEntity;

public record WorkerResponse(
    Long id,
    String userId,
    String name
) {

    public static WorkerResponse of(Long id, String userId, String name) {
        return new WorkerResponse(id, userId, name);
    }

    public static WorkerResponse from(WorkerEntity entity) {
        return WorkerResponse.of(
            entity.getId(),
            entity.getUserId(),
            entity.getName()
        );
    }
}
