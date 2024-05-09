package org.ssafy.load.security;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.http.HttpResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.common.exception.CommonException;

@RequiredArgsConstructor
public class JwtFilter implements Filter {

    private final ObjectMapper objectMapper = new ObjectMapper();
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
            errorResponse(httpResponse, ErrorCode.INVALID_TOKEN);
            return;
        }

        String token = authorizationHeader.substring(7); //"Bearer "이후의 토큰 추출

        try {
            jwtTokenProvider.validateToken(token);
        } catch (Exception e) {
            errorResponse(httpResponse, ErrorCode.INVALID_TOKEN);
            return;
        }

        Long id = jwtTokenProvider.getId(token);
        String role = jwtTokenProvider.getRole(token);
        if (httpRequest.getRequestURI().startsWith("/api/admin") && !role.equals("admin")) {
            errorResponse(httpResponse, ErrorCode.ACCESS_DENIED);
            return;
        }
        request.setAttribute("id", id);
        request.setAttribute("role", role);
        chain.doFilter(request, response);
    }

    private void errorResponse(HttpServletResponse response, ErrorCode errorCode) throws IOException {
        response.setStatus(errorCode.getStatus().value());
        response.setContentType("application/json");
        String json = objectMapper.writeValueAsString(Response.error(errorCode.name()));
        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }
}