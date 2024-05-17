package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.PathTimeEntity;
import org.ssafy.load.dto.Coordinate;
import org.ssafy.load.dto.PathResult;
import org.ssafy.load.dto.request.BuildingRegistRequest;
import org.ssafy.load.dto.request.anylogic.AreaAndBuilding;
import org.ssafy.load.dto.request.anylogic.InputSettingResponse;
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
    private final BuildingJoinArea buildingJoinArea;
    private final GoodsRepository goodsRepository;

    @Transactional
    public void registBuilding(BuildingRegistRequest buildingRegistRequest) {
        Optional<AreaEntity> areaEntityOptional = areaRepository.findById(buildingRegistRequest.areaId());
        AreaEntity areaEntity = areaEntityOptional.orElseThrow(() -> new CommonException(ErrorCode.INVALID_PK));

        List<BuildingEntity> buildingEntityList = buildingRepository.findByArea(areaEntity);

        String sourceAddress = new StringBuilder()
                .append(buildingRegistRequest.sidoName())
                .append(" ")
                .append(buildingRegistRequest.gugunName())
                .append(" ")
                .append(buildingRegistRequest.dongName())
                .append(" ")
                .append(buildingRegistRequest.zibunMain())
                .append("-")
                .append(buildingRegistRequest.zibunSub()).toString();

        Coordinate coordinate = pathTimeCal.toCoordinate(sourceAddress);
        BuildingEntity srcBuilding = buildingRepository.save(BuildingEntity.createNewEntity(buildingRegistRequest, coordinate, areaEntity));

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

            PathResult pathResult = pathTimeCal.getPathTime(sourceAddress, desAddress);
            pathTimeRepository.save(PathTimeEntity.createNewEntity(srcBuilding, desBuilding, pathResult.duration(), pathResult.distance()));
        }
    }
    @Transactional
    public InputSettingResponse getInputSettingInfo(){
        List<AreaEntity> areaEntities = areaRepository.findAll();

        List<Integer> goodsCountPerArea = new ArrayList<>();
        for(AreaEntity areaEntity : areaEntities){
            goodsCountPerArea.add(areaEntity.getCount());
        }

        List<AreaAndBuilding> queryResponse = buildingJoinArea.getBuildingIdAndAreaId();

        // agent 마지막 id 조회
        GoodsEntity lastGoodsEntity = goodsRepository.findFirstByOrderByIdDesc().orElse(null);
        long agentId = 0L;
        if (lastGoodsEntity != null) {
            agentId= lastGoodsEntity.getAgentId();
        }

        return InputSettingResponse.of(goodsCountPerArea, queryResponse, agentId);
    }

}
