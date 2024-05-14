package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;

import java.util.List;
import java.util.Optional;


public interface GoodsRepository extends JpaRepository<GoodsEntity, Long> {
    List<GoodsEntity> findAllByLoadTaskIdOrderByOrderingAsc(Integer loadTaskId);
    @Query("select goods from GoodsEntity goods join fetch goods.building join fetch goods.boxType join goods.loadTask where goods.loadTask.id = :loadTaskId")
    List<GoodsEntity> findByLoadTask(int loadTaskId);

    @Query(value = "SELECT COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE()", nativeQuery = true)
    long countAllGoodsByCreatedAtIsToday();

    @Query(value = "SELECT COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE() and load_task_id is null", nativeQuery = true)
    long countStoredGoodsByCreatedAtIsToday();

    @Query(value = "SELECT COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE() and load_task_id is not null", nativeQuery = true)
    long countLoadedGoodsByCreatedAtIsToday();

    @Query(value = "SELECT DATE(created_at) as date, COUNT(*) as count FROM goods WHERE DATE(created_at) >= CURDATE() - INTERVAL 6 DAY AND DATE(created_at) <= CURDATE() GROUP BY DATE(created_at) ORDER BY date", nativeQuery = true)
    List<Object[]> countGoodsByDateForLastSixDays();

    @Query(value = "SELECT * FROM goods WHERE DATE(created_at) = CURDATE()", nativeQuery = true)
    List<GoodsEntity> findAllGoodsByCreatedAtIsToday();

    @Query(value = "SELECT * FROM goods WHERE DATE(created_at) = CURDATE() AND load_task_id is not null", nativeQuery = true)
    List<GoodsEntity> findAllLoadedGoodsByCreatedAtIsToday();

    @Query(value = "SELECT box_type_id as type, COUNT(*) as count FROM goods WHERE DATE(created_at) = CURDATE() GROUP BY box_type_id", nativeQuery = true)
    List<Object[]> countBoxTypeByCreatedAtIsToday();

    @Query(value = "SELECT building_id, COUNT(*) FROM goods WHERE DATE(created_at) = CURDATE() GROUP BY building_id", nativeQuery = true)
    List<Object[]> countGoodsByBuildingIdAndCreatedAtIsToday();

    List<GoodsEntity> findAllByAgentId(long agentId);

    long countByLoadTaskId(Integer loadTaskId);
}
