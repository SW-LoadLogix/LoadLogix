package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.BuildingEntity;

import java.util.List;


public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
    @Query("SELECT b.area.id, COUNT(b.area.id) FROM BuildingEntity b GROUP BY b.area.id")
    List<Object[]> getBuildingCountsByArea();

    List<BuildingEntity> findByArea(AreaEntity area);
}
