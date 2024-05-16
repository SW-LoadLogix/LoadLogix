package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.dao.PathRepository;
import org.ssafy.load.dao.PathTimeRepository;
import org.ssafy.load.dao.WorkerRepository;
import org.ssafy.load.domain.*;
import org.ssafy.load.dto.response.PathResponse;
import org.ssafy.load.util.PathOrderCalV2;

import java.util.*;

@Service
@RequiredArgsConstructor
public class PathService {
    private final WorkerRepository workerRepository;
    private final LoadTaskRepository loadTaskRepository;
    private final PathTimeRepository pathTimeRepository;
    private final PathRepository pathRepository;

    @Transactional
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

        PathOrderCalV2 pathOrderCal = new PathOrderCalV2(pathTImeMatrix, size, buildingEntityList);
        return pathOrderCal.getPathOrder();
    }

    @Transactional
    public List<PathResponse> getDeliveryPath(Long workerId) {
        WorkerEntity worker = workerRepository.findById(workerId)
                .orElseThrow(() -> new CommonException(ErrorCode.USER_NOT_FOUND));

        AreaEntity area = Optional.ofNullable(worker.getArea())
                .orElseThrow(() -> new CommonException(ErrorCode.AREA_NOT_FOUND));

        List<LoadTaskEntity> loadTaskList = loadTaskRepository.findByWorkerCompletedTask(area.getId());
        if(loadTaskList.isEmpty()) return null;

        List<PathEntity> pathEntityList = pathRepository.findAllByTaskId(loadTaskList.get(0).getId());

        List<PathResponse> pathResponseList = new ArrayList<>();
        for(PathEntity pathEntity : pathEntityList) {
            pathResponseList.add(new PathResponse(
                    pathEntity.getBuilding().getId(),
                    pathEntity.getBuilding().getDongName() + " " + pathEntity.getBuilding().getZibunMain() + "-" + pathEntity.getBuilding().getZibunSub(),
                    pathEntity.getBuilding().getLatitude(),
                    pathEntity.getBuilding().getLongitude(),
                    pathEntity.getBuilding().getGoodsEntities().size()
            ));
        }
        return pathResponseList;
    }
}
