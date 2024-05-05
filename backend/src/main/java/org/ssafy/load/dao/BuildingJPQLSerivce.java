package org.ssafy.load.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BuildingJPQLSerivce {
    @PersistenceContext
    private EntityManager entityManager;

    public List<Object[]> getBuildingCountsByArea() {
        String jpql = "SELECT ba.areaEntity.id, COUNT( ba.areaEntity.id) FROM BuildingEntity ba GROUP BY ba.areaEntity.id";
        return entityManager.createQuery(jpql).getResultList();
    }
}