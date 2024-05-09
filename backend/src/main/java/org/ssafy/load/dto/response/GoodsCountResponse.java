package org.ssafy.load.dto.response;

public record GoodsCountResponse(
    long totalCount,
    long storeCount,
    long loadCount
) {

}
