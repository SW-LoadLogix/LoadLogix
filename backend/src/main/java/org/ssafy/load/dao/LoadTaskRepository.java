package org.ssafy.load.dao;


import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.LoadTaskEntity;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {

    @Query("SELECT lt.id FROM LoadTaskEntity lt WHERE lt.complete = true and lt.area.id = :areaId ORDER BY lt.createdAt DESC")
    List<Integer> findMostRecentCompletedTaskIds(Integer areaId);
}
