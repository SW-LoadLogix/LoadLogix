package org.ssafy.load.application;

import io.swagger.v3.oas.models.security.SecurityScheme;
import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.BuildingRepository;
import org.ssafy.load.dao.GoodsRepository;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.dao.PathRepository;
import org.ssafy.load.domain.*;
import org.ssafy.load.dto.request.LoadResultGoodsRequest;
import org.ssafy.load.dto.request.LoadResultRequest;
import org.ssafy.load.dto.response.LoadTaskCarResponse;
import org.ssafy.load.dto.response.LoadTaskGoodsResponse;
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
    private final BuildingRepository buildingRepository;
    private final GoodsRepository goodsRepository;
    private final PathRepository pathRepository;

    @Transactional
    public LoadTaskResponse getLoadingTask() {
        Optional<LoadTaskEntity> loadTaskEntityOptional = loadTaskRepository.findFirstByAreaStatusIsTrueAndCompleteIsFalseOrderByCreatedAt();

        //작업 없음
        if(loadTaskEntityOptional.isEmpty()) {
            return null;
        }

        LoadTaskEntity loadTaskEntity = loadTaskEntityOptional.get();
        CarEntity carEntity = loadTaskEntity.getArea().getWorker().getCar();
        List<GoodsEntity> goodsEntityList = goodsRepository.findByLoadTask(loadTaskEntity);

        //Hard Coding (refactoring require!)
        //get start point building (삼성 연수원)
        Optional<BuildingEntity> SSAFYBuildingOptional = buildingRepository.findByZibunMainAndZibunSubAndArea(124, 0, loadTaskEntity.getArea());
        BuildingEntity SSAFYBuildingEntity = SSAFYBuildingOptional.orElseThrow(() -> new CommonException(ErrorCode.INTERNAL_SERVER_ERROR, "start point is not exist"));

        //경로 알고리즘 동작
        List<BuildingEntity> buildingEntityList = buildingRepository.findByLoadTask(loadTaskEntityOptional.get());
        buildingEntityList.addFirst(SSAFYBuildingEntity);
        buildingEntityList = pathService.calPathOrder(buildingEntityList);

        //경로 저장
        if(pathRepository.countByLoadTask(loadTaskEntity) == 0) {
            for(int order = 0; order < buildingEntityList.size(); order++) {
                pathRepository.save(PathEntity.createNewEntity(order + 1, loadTaskEntity, buildingEntityList.get(order)));
            }
        }

        //응답 생성
        List<Long> buildingIdOrder = new ArrayList<>();
        for(BuildingEntity buildingEntity : buildingEntityList) {
            buildingIdOrder.add(buildingEntity.getId());
        }

        LoadTaskCarResponse car = new LoadTaskCarResponse(
                carEntity.getWidth(),
                carEntity.getHeight(),
                carEntity.getLength(),
                carEntity.getMaxPayload());

        List<LoadTaskGoodsResponse> goods = new ArrayList<>();
        for(GoodsEntity goodsEntity : goodsEntityList) {
            goods.add(new LoadTaskGoodsResponse(
                    goodsEntity.getId(),
                    goodsEntity.getBoxType().getType().toString(),
                    goodsEntity.getWeight(),
                    goodsEntity.getBuilding().getId())
            );
        }

        return new LoadTaskResponse(
                loadTaskEntity.getId(),
                car,
                goods,
                buildingIdOrder
        );
    }

    @Transactional
    public void LoadResultRegist(LoadResultRequest loadResultRequest) {
        Optional<LoadTaskEntity> loadTaskEntityOptional = loadTaskRepository.findById(loadResultRequest.taskId());
        LoadTaskEntity loadTaskEntity = loadTaskEntityOptional.orElseThrow(() -> new CommonException(ErrorCode.INVALID_PK));

        for(LoadResultGoodsRequest item : loadResultRequest.goods()) {
            double x = item.loadResultPositionRequest().x();
            double y = item.loadResultPositionRequest().y();
            double z = item.loadResultPositionRequest().z();

            Optional<GoodsEntity> goodsEntityOptional = goodsRepository.findById(item.goodsId());
            GoodsEntity goodsEntity = goodsEntityOptional.orElseThrow(() -> new CommonException(ErrorCode.INVALID_PK));
            goodsEntity.setBoxPosition(x, y, z);
        }

        loadTaskEntity.withUpdatedComplete();
    }
}
