package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.PathTimeEntity;

import java.util.List;

public interface PathTimeRepository extends JpaRepository<PathTimeEntity, Long> {
    List<PathTimeEntity> findByBuilding1InAndBuilding2In(List<BuildingEntity> buildingEntityList1, List<BuildingEntity> buildingEntityList2);
}
