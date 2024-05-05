package org.ssafy.load.dto.response;

import org.ssafy.load.domain.CarEntity;

public record CarResponse(
    int width,
    int length,
    int height
) {
    public static CarResponse of(
        int width,
        int length,
        int height
    ){
        return new CarResponse(width, length, height);
    }

    public static CarResponse from (CarEntity entity){
        return new CarResponse(entity.getWidth(), entity.getLength(), entity.getHeight());
    }
}
