package org.ssafy.load.dto;

public record JwtToken(
        String grantType,
        String accessToken,
        String refreshToken
) {
}

