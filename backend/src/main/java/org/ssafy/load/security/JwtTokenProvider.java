package org.ssafy.load.security;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.*;
import java.util.Base64;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.ssafy.load.common.exception.JWTException;
import java.util.Date;

@Slf4j
@Component
public class JwtTokenProvider {

//    private final long EXPIRATION_SECOND = 60 * 60 * 2; //2시간
//    private final Key key;
//    public JwtTokenProvider(@Value("${jwt.secret}") String secretKey) {
//        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
//        this.key = Keys.hmacShaKeyFor(keyBytes);
//    }

    private static final String SECRET_KEY = "30ec8320ca7ad94e3b7ad0a010e6bbc2e81a92c4efacb4badea20d669f4c9769";
    private static final long EXPIRATION_SECOND = 60 * 60 * 2; //2시간

    // Member 정보를 가지고 AccessToken을 생성하는 메서드
    public String generateToken(String userId, String name) {

        long now = System.currentTimeMillis();

        Claims claims = Jwts.claims();
        claims.put("userId", userId);
        claims.put("name", name);

        //토큰 생성
        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(new Date(now + 1000 * EXPIRATION_SECOND))
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    // 토큰 정보를 검증하는 메서드
    public Jws<Claims> validateToken(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token);
    }

    // Jwt 토큰을 복호화하여 토큰에 들어있는 정보를 꺼내는 메서드
    public String getUserId(String token) {
        Base64.Decoder decoder = Base64.getDecoder();
        String[] splitToken = token.split("\\.");
        String json = new String(decoder.decode(splitToken[1]));

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            Map<String, Object> map = objectMapper.readValue(json, Map.class);
            return (String) map.get("userId");
        } catch (JsonProcessingException e) {
            throw new JWTException(e);
        }
    }
}
