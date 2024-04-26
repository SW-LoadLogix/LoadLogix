package org.ssafy.load.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.AddressEntity;

public interface AddressRepository extends JpaRepository<AddressEntity, Long> {
}
