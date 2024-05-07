package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.GoodsRepository;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.dto.response.LoadTaskResponse;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class TaskService {

    private final PathService pathService;
    private final LoadTaskRepository loadTaskRepository;
    private final GoodsRepository goodsRepository;

    public LoadTaskResponse getLoadingTask() {
        Optional<LoadTaskEntity> loadTaskEntityOptional = loadTaskRepository.findFirstByAreaStatusIsTrueAndCompleteIsFalseOrderByCreatedAt();

        if(loadTaskEntityOptional.isEmpty()) {
            return null;
        }

        List<BuildingEntity> buildingEntityList = goodsRepository.findBuildingByLoadTask(loadTaskEntityOptional.get());
        System.out.println("알고리즘 전 사이즈: " + buildingEntityList.size());
        
        buildingEntityList = pathService.calPathOrder(buildingEntityList);

        System.out.println("알고리즘 후 사이즈: " + buildingEntityList.size());
        for(BuildingEntity buildingEntity : buildingEntityList) {
            System.out.println(buildingEntity.getId());
        }
        return null;
    }
}
