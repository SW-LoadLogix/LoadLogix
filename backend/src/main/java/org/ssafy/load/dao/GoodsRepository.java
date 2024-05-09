package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;


public interface GoodsRepository extends JpaRepository<GoodsEntity, Long> {
    List<GoodsEntity> findAllByBuildingId(Long buildingId);
    List<GoodsEntity> findAllByLoadTaskIdOrderByOrderingAsc(Integer loadTaskId);
    @Query("select goods from GoodsEntity goods join fetch goods.building join fetch goods.boxType inner join goods.loadTask where goods.loadTask.id = :loadTaskId")
    List<GoodsEntity> findByLoadTask(int loadTaskId);
}
