package org.ssafy.load.dto.response;

public record BoxTypeResponse(
    Integer id,
    String type,
    int height,
    int length,
    int width,
    long totalCount
) {

}
