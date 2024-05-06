package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.PathTimeEntity;

public interface PathTimeRepository extends JpaRepository<PathTimeEntity, Long> {
    
}
