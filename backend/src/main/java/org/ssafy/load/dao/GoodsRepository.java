package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;


public interface GoodsRepository extends JpaRepository<GoodsEntity, Long> {
    List<GoodsEntity> findAllByBuildingId(Long buildingId);
    @Query("select DISTINCT building from GoodsEntity goods inner join goods.building building where goods.loadTask= :loadTask order by building.id")
    List<BuildingEntity> findBuildingByLoadTask(LoadTaskEntity loadTask);
}

