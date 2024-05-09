package org.ssafy.load.application;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.CarRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.CarEntity;
import org.ssafy.load.domain.WorkerEntity;
import org.ssafy.load.dto.request.CarChangeRequest;
import org.ssafy.load.dto.response.CarResponse;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CarService {
    private final WorkerRepository workerRepository;
    private final CarRepository carRepository;

    @Transactional
    public CarResponse updateCarSize(CarChangeRequest carChangeRequest, Long workerId) {
        Optional<WorkerEntity> workerOptional = workerRepository.findById(workerId);
        WorkerEntity worker = workerOptional.orElseThrow(() -> new CommonException(ErrorCode.USER_NOT_FOUND));

        CarEntity car = worker.getCar();
        if (car == null) {
            car = carRepository.save(CarEntity.createEmptyNewEntity());
        }

        //사용자 입력 받게끔 수정 필요, 지금은 1톤 적재량(1000000g)으로 설정
        car.updateCar(carChangeRequest.carHeight(), carChangeRequest.carLength(), carChangeRequest.carWidth(), 1000000);
        return CarResponse.from(car);
    }
}
