package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.ssafy.load.domain.AreaReadyStatusEntity;

public interface AreaReadyStatusRepository extends JpaRepository<AreaReadyStatusEntity, Integer> {
}
