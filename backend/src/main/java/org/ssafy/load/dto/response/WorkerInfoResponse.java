package org.ssafy.load.dto.response;

import org.ssafy.load.domain.WorkerEntity;

public record WorkerInfoResponse(
        String name,
        String areaName,
        int conveyNo,
        int carHeight,
        int carLength,
        int carWidth
) {
    public static WorkerInfoResponse from(WorkerEntity entity) {
        return new WorkerInfoResponse(
                entity.getName(),
                entity.getArea().getAreaName(),
                entity.getArea().getConveyNo(),
                entity.getCar().getHeight(),
                entity.getCar().getLength(),
                entity.getCar().getWidth()
        );
    }
}
