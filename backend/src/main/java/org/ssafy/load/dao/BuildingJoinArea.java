package org.ssafy.load.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Component;
import org.ssafy.load.dto.request.anylogic.AreaAndBuilding;

import java.util.ArrayList;
import java.util.List;

@Component
public class BuildingJoinArea {
    @PersistenceContext
    private EntityManager entityManager;

    public List<AreaAndBuilding> getBuildingIdAndAreaId(){
        String jpql = "SELECT b.id, a.id FROM BuildingEntity b LEFT JOIN AreaEntity a ON b.area.id = a.id";
        List<Object[]> rows = entityManager.createQuery(jpql).getResultList();
        List<AreaAndBuilding> areaAndBuildings = new ArrayList<>();
        for(Object[] row : rows){
            Long buildingId = (Long) row[0];
            Integer areaId = (Integer) row[1];
            areaAndBuildings.add(AreaAndBuilding.of(buildingId, areaId));
        }
        return areaAndBuildings;
    }
}
