package org.ssafy.load.dto.response;

import java.util.List;
import org.ssafy.load.dto.TotalDayGoods;

public record GoodsTotalResponse(
    List<TotalDayGoods> amount
) {

    public static GoodsTotalResponse of(List<TotalDayGoods> list) {
        return new GoodsTotalResponse(list);
    }
}
