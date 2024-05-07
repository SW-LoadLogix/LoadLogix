package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.BuildingEntity;

import java.util.List;


public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
    @Query("SELECT b.id FROM BuildingEntity b WHERE b.area.id = :areaId")
    List<Long> findIdsByAreaId(Integer areaId);
    List<BuildingEntity> findByArea(AreaEntity area);
}
