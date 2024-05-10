package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {
    @Query("SELECT lt.id FROM LoadTaskEntity lt WHERE lt.complete = true and lt.area.id = :areaId ORDER BY lt.createdAt DESC")
    List<Integer> findMostRecentCompletedTaskIds(Integer areaId);
    List<LoadTaskEntity> findAllByAreaIdOrderByCreatedAtDesc(Integer areaId);
    Optional<LoadTaskEntity> findFirstByAreaStatusIsTrueAndCompleteIsFalseOrderByCreatedAt();
}
