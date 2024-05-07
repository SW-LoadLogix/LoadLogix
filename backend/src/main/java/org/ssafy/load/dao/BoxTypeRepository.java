package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.common.type.BoxType;
import org.ssafy.load.domain.BoxTypeEntity;

import java.util.Optional;

public interface BoxTypeRepository extends JpaRepository<BoxTypeEntity, Integer> {
    Optional<BoxTypeEntity> findByType(BoxType type);

}
