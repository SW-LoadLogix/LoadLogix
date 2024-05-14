package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.CarEntity;


public interface CarRepository extends JpaRepository<CarEntity, Long> {

}
