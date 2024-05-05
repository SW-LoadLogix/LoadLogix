package org.ssafy.load.dto.response;

import org.ssafy.load.domain.WorkerEntity;

public record WorkerResponse(
    String name
) {

    public static WorkerResponse of(String name) {
        return new WorkerResponse(name);
    }

    public static WorkerResponse from(WorkerEntity entity) {
        return WorkerResponse.of(
            entity.getName()
        );
    }
}
