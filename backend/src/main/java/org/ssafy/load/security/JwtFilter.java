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

    private final JwtTokenProvider jwtTokenProvider;

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

        if (httpRequest.getRequestURI().equals("/api/worker/signup") || httpRequest.getRequestURI().equals("/api/worker/login")) {
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
            jwtTokenProvider.validateToken(token);
        } catch (Exception e) {
            throw new CommonException(ErrorCode.INVALID_TOKEN);
        }

        Long id = jwtTokenProvider.getId(token);
        String role = jwtTokenProvider.getRole(token);
        if (httpRequest.getRequestURI().startsWith("/api/admin") && !role.equals("admin")) {
            throw new CommonException(ErrorCode.ACCESS_DENIED);
        }
        request.setAttribute("id", id);
        request.setAttribute("role", role);
        chain.doFilter(request, response);
    }
}