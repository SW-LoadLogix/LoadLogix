package org.ssafy.load.dto.response.worker;

public record LoginResponse(
    String token
) {

    public static LoginResponse of(String token) {
        return new LoginResponse(token);
    }
}
