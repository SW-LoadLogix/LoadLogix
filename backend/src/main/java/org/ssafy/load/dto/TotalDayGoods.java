package org.ssafy.load.dto;

import java.time.LocalDate;

public record TotalDayGoods(
    LocalDate date,
    int total
) {

}
