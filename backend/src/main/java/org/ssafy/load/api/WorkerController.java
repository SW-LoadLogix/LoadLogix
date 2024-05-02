package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.WorkerService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.request.SignupRequest;
import org.ssafy.load.dto.response.WorkerResponse;

@RequiredArgsConstructor
@RestController
@RequestMapping("/worker")
public class WorkerController {

    public final WorkerService workerService;

    @PostMapping("/signup")
    public Response<WorkerResponse> singup(SignupRequest signupRequest) {
        return Response.success(workerService.signup(signupRequest));
    }

    @PostMapping("/login")
    public Response<String> login(LoginRequest loginRequest) {
        return Response.success(workerService.login(loginRequest));
    }
}
