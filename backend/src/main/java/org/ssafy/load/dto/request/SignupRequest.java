package org.ssafy.load.dto.request;

public record SignupRequest(
    String userId,
    String password,
    String name
) {

}
