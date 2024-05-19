package org.ssafy.load.dto.request.worker;

public record SignUpRequest(
    String id,
    String password,
    String name
) {

}
