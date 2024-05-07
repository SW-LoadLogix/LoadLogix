package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {
    Optional<LoadTaskEntity> findFirstByAreaStatusIsTrueAndCompleteIsFalseOrderByCreatedAt();
}
