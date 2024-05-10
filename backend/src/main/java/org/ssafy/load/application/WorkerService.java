package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.CarRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.CarEntity;
import org.ssafy.load.domain.WorkerEntity;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.request.SignUpRequest;
import org.ssafy.load.dto.response.LoginResponse;
import org.ssafy.load.dto.response.SignUpResponse;
import org.ssafy.load.dto.response.WorkerInfoResponse;
import org.ssafy.load.security.JwtTokenProvider;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class WorkerService {

    private final JwtTokenProvider jwtTokenProvider;
    private final WorkerRepository workerRepository;
    private final CarRepository carRepository;

    public SignUpResponse signup(SignUpRequest signUpRequest) {
        Optional<WorkerEntity> worker = workerRepository.findByLoginId(signUpRequest.id());
        if (worker.isPresent()) {
            throw new CommonException(ErrorCode.USER_ALREADY_EXISTS);
        }
        CarEntity car = carRepository.save(CarEntity.of(null, 0, 0, 0, null,null));
        return SignUpResponse.from(workerRepository.save(
                WorkerEntity.of(null, signUpRequest.id(), signUpRequest.password(),
                        signUpRequest.name(), car, null)));
    }

    public LoginResponse login(LoginRequest loginRequest) {
        Optional<WorkerEntity> worker = workerRepository.findByLoginIdAndPassword(
                loginRequest.id(),
                loginRequest.password());

        if (worker.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }
        return LoginResponse.of(
                jwtTokenProvider.generateToken(worker.get().getId(), worker.get().getName(),
                        "worker"));
    }

    @Transactional(readOnly = true)
    public WorkerInfoResponse getWorkerInfo(Long workerId){
        Optional<WorkerEntity> worker = workerRepository.findById(workerId);
        if (worker.isEmpty())
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        return WorkerInfoResponse.from(worker.get());
    }
}
