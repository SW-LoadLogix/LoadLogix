package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.AdminService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.response.LoginResponse;
import org.ssafy.load.security.JwtTokenProvider;

@RequiredArgsConstructor
@RestController
@RequestMapping("/admin")
public class AdminController {

    private final JwtTokenProvider jwtTokenProvider;
    private final AdminService adminService;

    @PostMapping("/login")
    public Response<LoginResponse> login(@RequestBody LoginRequest loginRequest){
        return Response.success(adminService.login(loginRequest));
    }
}
