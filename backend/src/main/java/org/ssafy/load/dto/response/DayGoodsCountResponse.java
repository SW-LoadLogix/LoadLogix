package org.ssafy.load.dto.response;

import java.time.LocalDate;

public record DayGoodsCountResponse(
    LocalDate date,
    long totalGoods
) {

}
