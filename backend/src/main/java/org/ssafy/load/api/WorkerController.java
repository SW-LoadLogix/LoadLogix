package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.ssafy.load.application.WorkerService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.request.SignUpRequest;
import org.ssafy.load.dto.response.LoginResponse;
import org.ssafy.load.dto.response.SignUpResponse;
import org.ssafy.load.dto.response.WorkerResponse;
import org.ssafy.load.security.JwtTokenProvider;

@RequiredArgsConstructor
@RestController
@RequestMapping("/worker")
public class WorkerController {

    public final WorkerService workerService;
    public final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/signup")
    public Response<SignUpResponse> signup(@RequestBody SignUpRequest signupRequest) {
        return Response.success(workerService.signup(signupRequest));
    }

    @PostMapping("/login")
    public Response<LoginResponse> login(@RequestBody LoginRequest loginRequest) {
        return Response.success(workerService.login(loginRequest));
    }

    @PutMapping("/ready")
    public Response<Boolean> setWorkerReady(
            @RequestHeader(name="Authorized") String token
            ){
        Long id = jwtTokenProvider.getId(token);
        return Response.success(workerService.setReadyCompletedWorker(id));
    }
}
