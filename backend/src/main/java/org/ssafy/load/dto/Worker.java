package org.ssafy.load.dto;

import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.domain.WorkerEntity;
import java.util.List;

public record Worker(
        Long id,
        String loginId,
        String password,
        String name,
        Long carId,
        Integer areaId,
        Long workerReadyStatusId,
        List<Long> loadTaskIds
) {

    public static Worker from(WorkerEntity entity) {
        Long carId = entity.getCar() != null ? entity.getCar().getId() : null;
        Integer areaId = entity.getArea() != null ? entity.getArea().getId() : null;
        Long workerReadyStatusId = entity.getWorkerReadyStatus() != null ? entity.getWorkerReadyStatus().getId() : null;
        List<Long> loadTaskIds = entity.getLoadTaskEntities() != null ?
                entity.getLoadTaskEntities().stream()
                        .map(LoadTaskEntity::getId)
                        .toList() : null;

        return new Worker(
                entity.getId(),
                entity.getLoginId(),
                entity.getPassword(),
                entity.getName(),
                carId,
                areaId,
                workerReadyStatusId,
                loadTaskIds
        );
    }
}