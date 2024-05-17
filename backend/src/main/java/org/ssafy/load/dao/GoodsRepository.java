package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;


public interface GoodsRepository extends JpaRepository<GoodsEntity, Long> {
    List<GoodsEntity> findAllByLoadTaskIdOrderByOrderingAsc(Integer loadTaskId);
    List<GoodsEntity> findAllByLoadTaskIdOrderByOrderingDesc(Integer loadTaskId);
    @Query("select goods from GoodsEntity goods join fetch goods.building join fetch goods.boxType join goods.loadTask where goods.loadTask.id = :loadTaskId")
    List<GoodsEntity> findByLoadTask(int loadTaskId);

    @Query(value = "SELECT COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE()", nativeQuery = true)
    long countAllGoodsByCreatedAtIsToday();

    @Query(value = "SELECT COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE() and load_task_id is null", nativeQuery = true)
    long countStoredGoodsByCreatedAtIsToday();

    @Query(value = "SELECT COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE() and load_task_id is not null", nativeQuery = true)
    long countLoadedGoodsByCreatedAtIsToday();

    @Query(value = "SELECT * FROM goods WHERE DATE(created_at) = CURDATE()", nativeQuery = true)
    List<GoodsEntity> findAllGoodsByCreatedAtIsToday();

    @Query(value = "SELECT * FROM goods WHERE DATE(created_at) = CURDATE() AND load_task_id is not null", nativeQuery = true)
    List<GoodsEntity> findAllLoadedGoodsByCreatedAtIsToday();

    @Query(value = "SELECT COUNT(*) FROM goods WHERE box_type_id=:boxTypeId AND DATE(created_at) = CURDATE()", nativeQuery = true)
    long countBoxTypeByCreatedAtIsToday(Integer boxTypeId);

    @Query(value = "SELECT building_id, COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE() GROUP BY building_id", nativeQuery = true)
    List<Object[]> countGoodsByBuildingIdAndCreatedAtIsToday();

    List<GoodsEntity> findAllByAgentId(long agentId);

    long countByLoadTaskId(Integer loadTaskId);

    Optional<GoodsEntity> findFirstByOrderByIdDesc();
}
