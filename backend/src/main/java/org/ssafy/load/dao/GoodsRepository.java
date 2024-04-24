package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.GoodsEntity;


public interface GoodsRepository extends JpaRepository<GoodsEntity, Long> {

}
