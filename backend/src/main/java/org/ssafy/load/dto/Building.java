package org.ssafy.load.dto;

import java.util.List;

public record Building(
        String address,
        int totalGoods,
        List<Goods> goods
) {
}
