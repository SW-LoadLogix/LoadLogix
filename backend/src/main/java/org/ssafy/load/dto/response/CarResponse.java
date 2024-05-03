package org.ssafy.load.dto.response;

import org.ssafy.load.domain.CarEntity;

public record CarResponse(
    int width,
    int height,
    int length
) {
    public static CarResponse of(
        int width,
        int height,
        int length){
        return new CarResponse(width, height, length);
    }

    public static CarResponse from (CarEntity entity){
        return new CarResponse(entity.getWidth(), entity.getHeight(), entity.getLength());
    }
}
