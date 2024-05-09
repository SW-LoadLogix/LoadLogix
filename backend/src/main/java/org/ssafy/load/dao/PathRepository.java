package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.domain.PathEntity;

import java.util.List;

public interface PathRepository extends JpaRepository<PathEntity, Long> {
    int countByLoadTask (LoadTaskEntity loadTask);
}
