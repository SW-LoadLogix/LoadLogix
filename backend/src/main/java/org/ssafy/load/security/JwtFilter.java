package org.ssafy.load.security;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import java.io.IOException;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;

@RequiredArgsConstructor
public class JwtFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String authorizationHeader = httpRequest.getHeader("Authorization");

        if (httpRequest.getMethod().equals("OPTIONS")) {
            chain.doFilter(request, response);
            return;
        }

        if (httpRequest.getRequestURI().startsWith("/api/user")) {
            String method = httpRequest.getMethod();
            if (method.equals("GET") || method.equals("POST") || method.equals("OPTIONS")) {
                chain.doFilter(request, response);
                return;
            }
        }

        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            throw new CommonException(ErrorCode.INVALID_TOKEN);
        }
        String token = authorizationHeader.substring(7); //"Bearer "이후의 토큰 추출
        try {
            JwtTokenProvider.validateToken(token);
        } catch (Exception e) {
            throw new CommonException(ErrorCode.INVALID_TOKEN);
        }

        String userId = JwtTokenProvider.getUserId(token);
        request.setAttribute("userId", userId);
        chain.doFilter(request, response);
//        // 1. Request Header에서 JWT 토큰 추출
//        String token = resolveToken((HttpServletRequest) request);
//
//        // 2. validateToken으로 토큰 유효성 검사
//        if (token != null && jwtTokenProvider.validateToken(token)) {
//            // 토큰이 유효할 경우 토큰에서 Authentication 객체를 가지고 와서 SecurityContext에 저장
//            Authentication authentication = jwtTokenProvider.getAuthentication(token);
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//        }
//        chain.doFilter(request, response);
    }
}