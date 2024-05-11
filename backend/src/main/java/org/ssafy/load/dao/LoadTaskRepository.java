package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.areaStatus = true and lt.complete = false and lt.workerState = false ORDER BY lt.createdAt")
    List<LoadTaskEntity> findByAreaCompletedTask();
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = false ORDER BY lt.createdAt")
    List<LoadTaskEntity> findByAlgorithmCompletedTask(int areaId);
    @Query("SELECT lt.id FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = true ORDER BY lt.createdAt DESC")
    List<Integer> findAllByWorkerCompletedTask(int areaId);
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = true ORDER BY lt.createdAt DESC")
    List<LoadTaskEntity> findByWorkerCompletedTask(int areaId);
}
