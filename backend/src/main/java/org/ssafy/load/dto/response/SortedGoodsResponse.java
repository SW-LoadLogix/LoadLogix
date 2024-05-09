package org.ssafy.load.dto.response;

import java.util.List;
import org.ssafy.load.dto.SortedGoods;

public record SortedGoodsResponse(
    List<SortedGoods> goods
) {

}
