package org.ssafy.load.application;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
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

    @Transactional
    public CarResponse updateCarSize(CarChangeRequest carChangeRequest, Long workerId) {
        Optional<WorkerEntity> workerOptional = workerRepository.findById(workerId);
        WorkerEntity worker = workerOptional.orElseThrow(() -> new CommonException(ErrorCode.USER_NOT_FOUND));

        CarEntity car = worker.getCar();
        if (car == null)
            throw new CommonException(ErrorCode.CAR_NOT_FOUND);

        car.updateCar(carChangeRequest.carHeight(), carChangeRequest.carLength(), carChangeRequest.carWidth());
        return CarResponse.from(car);
    }
}
