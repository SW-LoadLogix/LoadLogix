package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;


public interface BuildingRepository extends JpaRepository<BuildingEntity, Long> {
    @Query("SELECT b.id FROM BuildingEntity b WHERE b.area.id = :areaId")
    List<Long> findIdsByAreaId(int areaId);
    List<BuildingEntity> findByArea(AreaEntity area);
    Optional<BuildingEntity> findByZibunMainAndZibunSubAndArea(int zibunMain, int zibunSub, AreaEntity area);
    @Query("select DISTINCT building from GoodsEntity goods inner join goods.building building where goods.loadTask= :loadTask order by building.id")
    List<BuildingEntity> findByLoadTask(LoadTaskEntity loadTask);
}
