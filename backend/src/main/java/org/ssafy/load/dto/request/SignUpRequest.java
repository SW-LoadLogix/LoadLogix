package org.ssafy.load.dto.request;

public record SignUpRequest(
    String id,
    String password,
    String name
) {

}
