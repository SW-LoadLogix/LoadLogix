package org.ssafy.load.application;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.WorkerEntity;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.request.SignupRequest;
import org.ssafy.load.dto.response.WorkerResponse;
import org.ssafy.load.security.JwtTokenProvider;

@Service
@RequiredArgsConstructor
public class WorkerService {

    private final JwtTokenProvider jwtTokenProvider;
    private final WorkerRepository workerRepository;

    public WorkerResponse signup(SignupRequest signupRequest) {
        Optional<WorkerEntity> worker = workerRepository.findByUserId(signupRequest.userId());
        if(worker.isPresent())
            throw new CommonException(ErrorCode.USER_ALREADY_EXISTS);
        return WorkerResponse.from(workerRepository.save(
            WorkerEntity.of(null, signupRequest.userId(), signupRequest.password(),
                signupRequest.name())));
    }

    public String login(LoginRequest loginRequest) {
        Optional<WorkerEntity> worker = workerRepository.findByUserIdAndPassword(
            loginRequest.userId(),
            loginRequest.password());

        if (worker.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }
        return jwtTokenProvider.generateToken(worker.get().getUserId(), worker.get().getName());
    }
}
