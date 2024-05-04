package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.AreaEntity;


public interface AreaRepository extends JpaRepository<AreaEntity, Integer> {
}
