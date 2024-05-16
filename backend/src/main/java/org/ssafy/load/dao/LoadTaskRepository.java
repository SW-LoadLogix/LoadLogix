package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.areaStatus = true and lt.complete = false and lt.workerState = false ORDER BY lt.createdAt")
    List<LoadTaskEntity> findByAreaCompletedTask();
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = false ORDER BY lt.createdAt")
    List<LoadTaskEntity> findByAlgorithmCompletedTask(int areaId);
    Optional<LoadTaskEntity> findFirstByAreaIdAndAreaStatusAndCompleteAndWorkerStateOrderByCreatedAtAsc(Integer areaId, boolean areaStatus, boolean complete, boolean workerStatus);

    @Query("SELECT lt.id FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = true ORDER BY lt.createdAt DESC")
    List<Integer> findAllByWorkerCompletedTask(int areaId);
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = true ORDER BY lt.createdAt DESC")
    List<LoadTaskEntity> findByWorkerCompletedTask(int areaId);
    @Query(value = "SELECT id FROM load_task WHERE area_id = :areaId AND area_status = TRUE AND complete = TRUE AND worker_status = TRUE AND DATE(created_at) = CURDATE() - INTERVAL :days DAY", nativeQuery = true)
    List<Integer> findLoadTaskIdsByAreaIdAndCreatedAt(int areaId, int days);

    @Query(value = "SELECT id FROM load_task WHERE area_status = TRUE AND complete = TRUE AND worker_status = TRUE AND DATE(created_at) = CURDATE() - INTERVAL :days DAY", nativeQuery = true)
    List<Integer> findLoadTaskIdsByCreatedAt(int days);

    @Query(value = "SELECT id FROM load_task WHERE area_status = TRUE AND complete = TRUE AND worker_status = TRUE AND DATE(created_at) = CURDATE()", nativeQuery = true)
    List<Integer> findAllLoadTaskIdsByCreatedAtIsToday();

}
