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
    private final AreaRepository areaRepository;
    private final BuildingRepository buildingRepository;
    private final GoodsRepository goodsRepository;
    private final LoadTaskRepository loadTaskRepository;
    private final BoxTypeRepository boxTypeRepository;

    public GoodsListResponse getOriginGoods(Long workerId) {
        //기사 조회
        Optional<WorkerEntity> workerEntityOptional = workerRepository.findById(workerId);
        WorkerEntity worker = workerEntityOptional.orElseThrow(() -> new CommonException(ErrorCode.USER_NOT_FOUND));

        //구역 조회
        Optional<AreaEntity> areaOptionalEntity = Optional.ofNullable(worker.getArea());
        AreaEntity area = areaOptionalEntity.orElseThrow(() -> new CommonException(ErrorCode.AREA_NOT_FOUND));

        List<Integer> loadTask = loadTaskRepository.findMostRecentCompletedTaskIds(area.getId());
        if(loadTask.isEmpty()) {
            throw new CommonException(ErrorCode.LOAD_TASK_NOT_FOUND);
        }

        //task에 할당된 상품 조회
        List<GoodsEntity> goodsEntityList = goodsRepository.findByLoadTask(loadTask.getFirst());
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
        Optional<WorkerEntity> worker = workerRepository.findById(workerId);
        if (worker.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }

        //구역 조회
        Optional<AreaEntity> area = areaRepository.findById(worker.get().getArea().getId());
        if (area.isEmpty()) {
            throw new CommonException(ErrorCode.AREA_NOT_FOUND);
        }

        // 배송 기사의 가장 최근 적재 리스트 조회
        List<Integer> loadTaskIds = loadTaskRepository.findMostRecentCompletedTaskIds(
            area.get().getId());

        if (loadTaskIds.isEmpty()) {
            throw new CommonException(ErrorCode.LOAD_TASK_NOT_FOUND);
        }

        Integer loadTaskId = loadTaskIds.getFirst();
        Optional<LoadTaskEntity> loadTask = loadTaskRepository.findById(loadTaskId);
        if (loadTask.isEmpty()) {
            throw new CommonException(ErrorCode.LOAD_TASK_NOT_FOUND);
        }

        if (!loadTask.get().getAreaStatus() || !loadTask.get().getWorkerState()) {
            throw new CommonException(ErrorCode.INVALID_LOAD_TASK);
        }

        List<GoodsEntity> goodsEntities = goodsRepository.findAllByLoadTaskIdOrderByOrderingAsc(
            loadTaskId);

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
