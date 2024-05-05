package org.ssafy.load.dto.response;

import org.ssafy.load.dto.Building;
import org.ssafy.load.dto.Goods;

import java.util.List;

public record GoodsResponse(
        String area,
        int total,
        List<Building> buildings
) {
}
