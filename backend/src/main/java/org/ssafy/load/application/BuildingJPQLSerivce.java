package org.ssafy.load.application;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BuildingJPQLSerivce {
    @PersistenceContext
    private EntityManager entityManager;

    public List<Object[]> getBuildingCountsByArea() {
        String jpql = "SELECT ba.area.id, COUNT( ba.area.id) FROM BuildingEntity ba GROUP BY ba.area.id";
        return entityManager.createQuery(jpql).getResultList();
    }
}