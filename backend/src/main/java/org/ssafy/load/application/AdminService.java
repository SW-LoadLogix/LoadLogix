package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AdminRepository;
import org.ssafy.load.domain.AdminEntity;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.response.LoginResponse;
import org.ssafy.load.security.JwtTokenProvider;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final JwtTokenProvider jwtTokenProvider;
    private final AdminRepository adminRepository;

    public LoginResponse login(LoginRequest loginRequest) {
        Optional<AdminEntity> admin = adminRepository.findByLoginIdAndPassword(loginRequest.id(), loginRequest.password());

        if (admin.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }
        return LoginResponse.of(
                jwtTokenProvider.generateToken(admin.get().getId(), admin.get().getName(),
                        "admin"));
    }

    public void initialSetting() {

    }
}
