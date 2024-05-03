package org.ssafy.load.application;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.WorkerEntity;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.request.SignUpRequest;
import org.ssafy.load.dto.response.LoginResponse;
import org.ssafy.load.dto.response.SignUpResponse;
import org.ssafy.load.dto.response.WorkerResponse;
import org.ssafy.load.security.JwtTokenProvider;

@Service
@RequiredArgsConstructor
public class WorkerService {

    private final JwtTokenProvider jwtTokenProvider;
    private final WorkerRepository workerRepository;

    public SignUpResponse signup(SignUpRequest signUpRequest) {
        Optional<WorkerEntity> worker = workerRepository.findByUserId(signUpRequest.id());
        if (worker.isPresent()) {
            throw new CommonException(ErrorCode.USER_ALREADY_EXISTS);
        }
        return SignUpResponse.from(workerRepository.save(
            WorkerEntity.of(null, signUpRequest.id(), signUpRequest.password(),
                signUpRequest.name())));
    }

    public LoginResponse login(LoginRequest loginRequest) {
        Optional<WorkerEntity> worker = workerRepository.findByUserIdAndPassword(
            loginRequest.id(),
            loginRequest.password());

        if (worker.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }
        return LoginResponse.of(
            jwtTokenProvider.generateToken(worker.get().getUserId(), worker.get().getName(),
                "worker"));
    }
}
