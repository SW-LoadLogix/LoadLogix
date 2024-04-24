package org.ssafy.load.dto;

import org.ssafy.load.domain.GoodsEntity;

public record Goods(
        Long id,
        int width,
        int length,
        int height,
        int weight
) {
    public static Goods of(Long id, int width, int length, int height, int weight){
        return new Goods(id, width, length, height, weight);
    }

    public static Goods form(GoodsEntity entity){
        return Goods.of(
                entity.getId(),
                entity.getWidth(),
                entity.getLength(),
                entity.getHeight(),
                entity.getWeight()
        );
    }
}
