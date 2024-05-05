package org.ssafy.load.dto.response;

import org.ssafy.load.domain.WorkerEntity;

public record SignUpResponse(
    Long id,
    String loginId,
    String name
) {

    public static SignUpResponse of(Long id, String loginId, String name) {
        return new SignUpResponse(id, loginId, name);
    }

    public static SignUpResponse from(WorkerEntity entity) {
        return SignUpResponse.of(
            entity.getId(),
            entity.getLoginId(),
            entity.getName()
        );
    }
}
