package org.ssafy.load.dao;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.WorkerEntity;

public interface WorkerRepository extends JpaRepository<WorkerEntity, Long> {

    Optional<WorkerEntity> findByUserIdAndPassword(String userId, String password);
    Optional<WorkerEntity> findByUserId(String userId);
}
