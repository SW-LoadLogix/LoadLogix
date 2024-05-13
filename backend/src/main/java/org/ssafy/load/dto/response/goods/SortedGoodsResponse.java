package org.ssafy.load.dto.response.goods;

import java.util.List;

public record SortedGoodsResponse(
    List<SortedGoods> goods
) {

}
