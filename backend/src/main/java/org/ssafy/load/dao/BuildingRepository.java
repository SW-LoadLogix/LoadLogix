package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.BuildingEntity;

import java.util.List;


public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
    @Query("SELECT ba.deliveryAreaEntity.id, COUNT(ba.deliveryAreaEntity.id) FROM BuildingEntity ba GROUP BY ba.deliveryAreaEntity.id")
    List<Object[]> getBuildingCountsByArea();

    List<BuildingEntity> findByAreaEntity(AreaEntity areaEntity);
}
