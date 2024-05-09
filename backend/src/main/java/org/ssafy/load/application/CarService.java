package org.ssafy.load.application;

import org.springframework.transaction.annotation.Transactional;
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
        Optional<WorkerEntity> worker = workerRepository.findById(workerId);
        if (worker.isEmpty())
            throw new CommonException(ErrorCode.USER_NOT_FOUND);

        Optional<CarEntity> car = carRepository.findById(worker.get().getCar().getId());
        if (car.isEmpty())
            throw new CommonException(ErrorCode.CAR_NOT_FOUND);

        car.get().updateCar(carChangeRequest.carHeight(), carChangeRequest.carLength(), carChangeRequest.carWidth());
        return CarResponse.from(car.get());
    }
}
