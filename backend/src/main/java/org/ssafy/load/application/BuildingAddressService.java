package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.BuildingAddressRepository;
import org.ssafy.load.domain.BuildingAddressEntity;
import org.ssafy.load.dto.response.BuildingResponse;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BuildingAddressService {
    private final BuildingJPQLSerivce buildingJPQLSerivce;

    public List<Integer> getAreaAndBuildingCount(){
        List<Object[]> result = buildingJPQLSerivce.getBuildingCountsByArea();
        List<Integer> response = new ArrayList<>();
        int prevNo = 0;
        for(Object[] row : result ){
            Integer areaId = (Integer) row[0];
            Long count = (Long) row[1];
            response.add((int) (prevNo + count));
            prevNo += count;
        }
        return response;
    }

}
