package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.PathTimeRepository;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.PathTimeEntity;
import org.ssafy.load.util.PathOrderCal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PathService {
    private final PathTimeRepository pathTimeRepository;

    public List<BuildingEntity> calPathOrder(List<BuildingEntity> buildingEntityList) {
        int size = buildingEntityList.size();
        int[][] pathTImeMatrix = new int[size][size];

        Map<BuildingEntity, Integer> buildingEntityToIndexMap = new HashMap<>();
        for(int index=0; index < size; index++) {
            buildingEntityToIndexMap.put(buildingEntityList.get(index), index);
        }

        List<PathTimeEntity> pathTimeEntityList = pathTimeRepository.findByBuilding1InAndBuilding2In(buildingEntityList, buildingEntityList);
        for(PathTimeEntity pathTimeEntity : pathTimeEntityList) {
            BuildingEntity srcBuilding = pathTimeEntity.getBuilding1();
            BuildingEntity desBuilding = pathTimeEntity.getBuilding2();
            int srcBuildingNum = buildingEntityToIndexMap.get(srcBuilding);
            int desBuildingNum = buildingEntityToIndexMap.get(desBuilding);
            pathTImeMatrix[srcBuildingNum][desBuildingNum] = pathTimeEntity.getDuration();
            pathTImeMatrix[desBuildingNum][srcBuildingNum] = pathTimeEntity.getDuration();
        }

        PathOrderCal pathOrderCal = new PathOrderCal(pathTImeMatrix, size, buildingEntityList);
        return pathOrderCal.getPathOrder();
    }
}
