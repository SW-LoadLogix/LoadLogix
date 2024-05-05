package org.ssafy.load.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.ssafy.load.domain.ReadyStatusEntity;

public interface ReadyStatusRepository extends JpaRepository<ReadyStatusEntity, Integer> {
}
