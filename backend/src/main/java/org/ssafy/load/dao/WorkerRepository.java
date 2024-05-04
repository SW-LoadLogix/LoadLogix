package org.ssafy.load.dao;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.WorkerEntity;

public interface WorkerRepository extends JpaRepository<WorkerEntity, Long> {

    Optional<WorkerEntity> findByLoginIdAndPassword(String loginId, String password);
    Optional<WorkerEntity> findByLoginId(String loginId);
}
