package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.BuildingAddressEntity;


public interface BuildingAddressRepository extends JpaRepository<BuildingAddressEntity, Long> {
}
