package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.LoadTaskEntity;

public interface LoadTaskRepository extends JpaRepository<LoadTaskEntity, Integer> {
}
