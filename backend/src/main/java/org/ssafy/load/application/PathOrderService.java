package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.dao.BuildingRepository;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.GoodsEntity;

import java.util.List;
import java.util.Set;
import java.util.TreeSet;

@Service
@RequiredArgsConstructor
public class PathOrderService {
    private final AreaRepository areaRepository;
    private final BuildingRepository buildingRepository;
    private final LoadTaskRepository loadTaskRepository;

    public void calPathOrder(Set<BuildingEntity> buildingEntitySet) {


    }
}
