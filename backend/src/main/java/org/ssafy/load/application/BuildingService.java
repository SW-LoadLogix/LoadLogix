package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.dao.BuildingRepository;
import org.ssafy.load.dao.PathTimeRepository;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.PathTimeEntity;
import org.ssafy.load.dto.request.BuildingRegistRequest;
import org.ssafy.load.util.PathTimeCal;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class BuildingService {

    private final AreaRepository areaRepository;
    private final BuildingRepository buildingRepository;
    private final PathTimeRepository pathTimeRepository;
    private final PathTimeCal pathTimeCal;

    public List<Integer> getAreaAndBuildingCount() {
        buildingRepository.getBuildingCountsByArea();

        List<Object[]> result = buildingRepository.getBuildingCountsByArea();
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

    @Transactional
    public void registBuilding(BuildingRegistRequest buildingRegistRequest) {
        Optional<AreaEntity> areaEntityOptional = areaRepository.findById(buildingRegistRequest.area_id());
        AreaEntity areaEntity = areaEntityOptional.orElseThrow(() -> new CommonException(ErrorCode.ACCESS_DENIED));

        BuildingEntity srcBuilding = buildingRepository.save(BuildingEntity.createNewEntity(buildingRegistRequest, areaEntity));
        List<BuildingEntity> buildingEntityList = buildingRepository.findByAreaEntity(areaEntity);

        String sourceAddress = new StringBuilder()
                .append(srcBuilding.getSidoName())
                .append(" ")
                .append(srcBuilding.getGugunName())
                .append(" ")
                .append(srcBuilding.getDongName())
                .append(" ")
                .append(srcBuilding.getZibunMain())
                .append("-")
                .append(srcBuilding.getZibunSub()).toString();

        for(BuildingEntity desBuilding : buildingEntityList) {
            String desAddress = new StringBuilder()
                    .append(desBuilding.getSidoName())
                    .append(" ")
                    .append(desBuilding.getGugunName())
                    .append(" ")
                    .append(desBuilding.getDongName())
                    .append(" ")
                    .append(desBuilding.getZibunMain())
                    .append("-")
                    .append(desBuilding.getZibunSub()).toString();

            Long duration = pathTimeCal.getPathTime(sourceAddress, desAddress);
            pathTimeRepository.save(PathTimeEntity.createNewEntity(srcBuilding, desBuilding, duration));
        }
    }
}
