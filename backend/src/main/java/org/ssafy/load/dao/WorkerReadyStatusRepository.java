package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.WorkerReadyStatusEntity;

public interface WorkerReadyStatusRepository extends JpaRepository<WorkerReadyStatusEntity, Long> {
}
