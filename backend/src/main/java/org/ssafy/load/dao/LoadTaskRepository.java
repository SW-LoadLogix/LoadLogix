package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {
    @Query("SELECT lt.id FROM LoadTaskEntity lt WHERE lt.areaStatus = true and lt.complete = true and lt.workerState = true and lt.area.id = :areaId ORDER BY lt.createdAt DESC")
    List<Integer> findMostRecentCompletedTaskIds(Integer areaId);
    @Query("SELECT lt FROM LoadTaskEntity lt WHERE lt.area.id = :areaId and lt.areaStatus = true and lt.complete = true and lt.workerState = false ORDER BY lt.createdAt")
    Optional<LoadTaskEntity> findOldWaitedTask(Integer areaId);
    Optional<LoadTaskEntity> findFirstByAreaStatusIsTrueAndCompleteIsFalseOrderByCreatedAt();
}
