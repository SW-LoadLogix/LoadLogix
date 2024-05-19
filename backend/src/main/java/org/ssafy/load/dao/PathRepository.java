package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.domain.PathEntity;

import java.util.List;

public interface PathRepository extends JpaRepository<PathEntity, Long> {
    int countByLoadTask (LoadTaskEntity loadTask);
    @Query("select distinct path from PathEntity path join fetch path.building join fetch path.building.goodsEntities where path.loadTask.id = :taskId order by path.priority")
    List<PathEntity> findAllByTaskId(int taskId);
}
