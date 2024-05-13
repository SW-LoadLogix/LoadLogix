package org.ssafy.load.dto.response.worker;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.ssafy.load.domain.WorkerEntity;

public record WorkerInfoResponse(
        String name,
        @JsonProperty("area_name")
        String areaName,
        @JsonProperty("convey_no")
        int conveyNo,
        @JsonProperty("car_height")
        int carHeight,
        @JsonProperty("car_length")
        int carLength,
        @JsonProperty("car_width")
        int carWidth
) {
    public static WorkerInfoResponse from(WorkerEntity entity) {
        if(entity.getCar() == null) {
            return new WorkerInfoResponse(
                    entity.getName(),
                    entity.getArea().getAreaName(),
                    entity.getArea().getConveyNo(),
                    0,
                    0,
                    0
            );
        }

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
