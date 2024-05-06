package org.ssafy.load.dto;

public record Goods(
        Long goodsId,
        String type,
        int weight,
        String address
) {
}

