package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.BuildingEntity;


public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
}
