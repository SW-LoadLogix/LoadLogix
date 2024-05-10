package org.ssafy.load.application;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.common.type.BoxType;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.*;
import org.ssafy.load.dto.Position;
import org.ssafy.load.dto.request.CreateGoodsRequest;
import org.ssafy.load.dto.response.*;

import java.util.*;

import org.ssafy.load.dto.SortedGoods;

@Service
@RequiredArgsConstructor
@Transactional
public class GoodsService {

    private final WorkerRepository workerRepository;
    private final BuildingRepository buildingRepository;
    private final GoodsRepository goodsRepository;
    private final LoadTaskRepository loadTaskRepository;
    private final BoxTypeRepository boxTypeRepository;

    public GoodsListResponse getOriginGoods(Long workerId) {
        //기사 조회
        Optional<WorkerEntity> workerOptional = workerRepository.findById(workerId);
        WorkerEntity worker = workerOptional.orElseThrow(() -> new CommonException(ErrorCode.USER_NOT_FOUND));

        //구역 조회
        Optional<AreaEntity> areaOptional = Optional.ofNullable(worker.getArea());
        AreaEntity area = areaOptional.orElseThrow(() -> new CommonException(ErrorCode.AREA_NOT_FOUND));

        //가장 최근 적재 조회
        List<Integer> loadTaskList = loadTaskRepository.findMostRecentCompletedTaskIds(area.getId());
        if(loadTaskList.isEmpty()) {
            throw new CommonException(ErrorCode.LOAD_TASK_NOT_FOUND);
        }

        //task에 할당된 상품 조회
        List<GoodsEntity> goodsEntityList = goodsRepository.findByLoadTask(loadTaskList.getFirst());
        Map<BuildingEntity, List<GoodsEntity>> buildingGoodsEntityMap = new HashMap<>();

        for(GoodsEntity goodsEntity : goodsEntityList) {
            buildingGoodsEntityMap.computeIfAbsent(goodsEntity.getBuilding(), k -> new ArrayList<>()).add(goodsEntity);
        }

        //응답 생성
        String areaName = area.getAreaName();
        int total = goodsEntityList.size();
        List<BuildingDetailResponse> buildingDetailResponseList = new ArrayList<>();

        for(BuildingEntity buildingEntity : buildingGoodsEntityMap.keySet()) {
            String topAddress = buildingEntity.getSidoName() + " " + buildingEntity.getGugunName();
            String buildingAddress = buildingEntity.getDongName() + " " + buildingEntity.getZibunMain() + "-" + buildingEntity.getZibunSub();
            int totalGoods = buildingGoodsEntityMap.get(buildingEntity).size();
            int totalPercentage = (int)((double)totalGoods / total * 100);
            List<GoodsDetailResponse> goodsDetailResponseList = new ArrayList<>();

            for (GoodsEntity goodsEntity : buildingGoodsEntityMap.get(buildingEntity)) {
                goodsDetailResponseList.add(
                        new GoodsDetailResponse(
                                goodsEntity.getId(),
                                goodsEntity.getBoxType().getType().name(),
                                goodsEntity.getBoxType().getHeight(),
                                goodsEntity.getBoxType().getLength(),
                                goodsEntity.getBoxType().getWidth(),
                                goodsEntity.getWeight(),
                                goodsEntity.getDetailAddress())
                );
            }

            buildingDetailResponseList.add(
                    new BuildingDetailResponse(
                            topAddress,
                            buildingAddress,
                            totalGoods,
                            totalPercentage,
                            goodsDetailResponseList)
            );
        }
        return new GoodsListResponse(areaName, total, buildingDetailResponseList);
    }

    public SortedGoodsResponse getSortedGoods(Long workerId) {
        //기사 조회
        Optional<WorkerEntity> workerEntityOptional = workerRepository.findById(workerId);
        WorkerEntity worker = workerEntityOptional.orElseThrow(() -> new CommonException(ErrorCode.USER_NOT_FOUND));

        //구역 조회
        Optional<AreaEntity> areaOptionalEntity = Optional.ofNullable(worker.getArea());
        AreaEntity area = areaOptionalEntity.orElseThrow(() -> new CommonException(ErrorCode.AREA_NOT_FOUND));

        //가장 최근 적재 조회
        List<Integer> loadTaskList = loadTaskRepository.findMostRecentCompletedTaskIds(area.getId());
        if(loadTaskList.isEmpty()) {
            throw new CommonException(ErrorCode.LOAD_TASK_NOT_FOUND);
        }

        List<GoodsEntity> goodsEntities = goodsRepository.findAllByLoadTaskIdOrderByOrderingAsc(loadTaskList.getFirst());
        List<SortedGoods> goods = goodsEntities.stream()
            .map(g -> new SortedGoods(
                g.getId(),
                String.valueOf(g.getBoxType().getType()),
                new Position(g.getX(), g.getY(), g.getZ()),
                g.getWeight(),
                g.getBuilding().getId(),
                g.getBuilding().getDongName() + " " + g.getBuilding().getZibunMain() + "-"
                    + g.getBuilding().getZibunSub(),
                g.getDetailAddress()
            )).toList();
        return new SortedGoodsResponse(goods);
    }

    public CreateGoodsResponse createGoods(CreateGoodsRequest createGoodsRequest) {
        return CreateGoodsResponse.from(goodsRepository.save(GoodsEntity.of(
            null,
            createGoodsRequest.weight(),
            createGoodsRequest.detailAddress(),
            null, null, null, null,
            boxTypeRepository.findByType(BoxType.valueOf("L" + createGoodsRequest.type()))
                .orElseThrow(() -> new CommonException(ErrorCode.INVALID_DATA)),
            buildingRepository.findById(createGoodsRequest.buildingId())
                .orElseThrow(() -> new CommonException(ErrorCode.INVALID_DATA)),
            null,null
            )));
    }
}
