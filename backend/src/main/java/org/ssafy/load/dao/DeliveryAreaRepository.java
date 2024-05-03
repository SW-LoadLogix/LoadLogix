package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.DeliveryAreaEntity;


public interface DeliveryAreaRepository extends JpaRepository<DeliveryAreaEntity, Integer> {
}
