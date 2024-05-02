package org.ssafy.load.security;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import java.util.Base64;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.ssafy.load.common.exception.JWTException;
import java.security.Key;
import java.util.Date;

@Slf4j
@Component
public class JwtTokenProvider {

    private static final String secretKey = "ssafy";

    private static final long EXPIRATION_SECOND = 60 * 60 * 2; //2시간
    private static final byte[] keyBytes = Decoders.BASE64.decode(secretKey);
    private static final Key key = Keys.hmacShaKeyFor(keyBytes);

    // Member 정보를 가지고 AccessToken을 생성하는 메서드
    public static String generateToken(String userId, String name) {

        long now = System.currentTimeMillis();

        Claims claims = Jwts.claims();
        claims.put("userId", userId);
        claims.put("name", name);

        //토큰 생성
        return Jwts.builder()
            .setClaims(claims)
            .setExpiration(new Date(now + 1000 * EXPIRATION_SECOND))
            .signWith(key, SignatureAlgorithm.HS256)
            .compact();
    }

    // 토큰 정보를 검증하는 메서드
    public static Jws<Claims> validateToken(String token) {
        return Jwts.parserBuilder()
            .setSigningKey(key)
            .build()
            .parseClaimsJws(token);
    }

    // Jwt 토큰을 복호화하여 토큰에 들어있는 정보를 꺼내는 메서드
    public static String getUserId(String token) {
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
        // Jwt 토큰 복호화
//        Claims claims = parseClaims(accessToken);
//
//        if (claims.get("auth") == null) {
//            throw new CommonException(ErrorCode.INVALID_TOKEN);
//        }
//
//        // 클레임에서 권한 정보 가져오기
//        Collection<? extends GrantedAuthority> authorities = Arrays.stream(
//                claims.get("auth").toString().split(","))
//            .map(SimpleGrantedAuthority::new)
//            .collect(Collectors.toList());
//
//        // UserDetails 객체를 만들어서 Authentication return
//        // UserDetails: interface, User: UserDetails를 구현한 class
//        UserDetails principal = new User(claims.getSubject(), "", authorities);
//        return new UsernamePasswordAuthenticationToken(principal, "", authorities);
    }

    // accessToken
//    private Claims parseClaims(String accessToken) {
//        try {
//            return Jwts.parserBuilder()
//                .setSigningKey(key)
//                .build()
//                .parseClaimsJws(accessToken)
//                .getBody();
//        } catch (ExpiredJwtException e) {
//            return e.getClaims();
//        }
//    }
}
