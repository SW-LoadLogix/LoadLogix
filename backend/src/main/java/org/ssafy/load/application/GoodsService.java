package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.common.type.BoxType;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.domain.WorkerEntity;
import org.ssafy.load.dto.Building;
import org.ssafy.load.dto.Goods;
import org.ssafy.load.dto.Position;
import org.ssafy.load.dto.request.CreateGoodsRequest;
import org.ssafy.load.dto.response.CreateGoodsResponse;
import org.ssafy.load.dto.response.GoodsCountResponse;
import org.ssafy.load.dto.response.GoodsResponse;

import java.util.List;
import java.util.Optional;
import org.ssafy.load.dto.SortedGoods;
import org.ssafy.load.dto.response.SortedGoodsResponse;

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

    @Transactional(readOnly = true)
    public GoodsResponse getOriginGoods(Long workerId) {
        //배송 기사 조회
        Optional<WorkerEntity> worker = workerRepository.findById(workerId);
        if (worker.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }

        //배송 기사의 구역 조회
        Optional<AreaEntity> area = areaRepository.findById(worker.get().getArea().getId());
        if (area.isEmpty()) {
            throw new CommonException(ErrorCode.AREA_NOT_FOUND);
        }

        //구역에 해당된 빌딩 id 조회
        List<Long> buildingIds = buildingRepository.findIdsByAreaId(area.get().getId());
        if (buildingIds.isEmpty()) {
            throw new CommonException(ErrorCode.BUILDING_NOT_FOUND);
        }

        // 빌딩별로 상품 조회
        List<Building> buildings = buildingIds.stream()
            .map(goodsRepository::findAllByBuildingId) // 상품 조회
            .filter(goodsEntities -> !goodsEntities.isEmpty()) // 비어있지 않은 상품 목록만 처리
            .map(goodsEntities -> {
                StringBuilder sb = new StringBuilder();
                sb.append(goodsEntities.getFirst().getBuilding().getSidoName() + " ")
                    .append(goodsEntities.getFirst().getBuilding().getGugunName() + " ")
                    .append(goodsEntities.getFirst().getBuilding().getDongName() + " ")
                    .append(goodsEntities.getFirst().getBuilding().getZibunMain() + " ")
                    .append(goodsEntities.getFirst().getBuilding().getZibunSub() + " ");
                String address = sb.toString();
                List<Goods> goods = goodsEntities.stream()
                    .map(g -> new Goods(
                        g.getId(),
                        String.valueOf(g.getBoxType().getType()),
                        g.getWeight(),
                        g.getDetailAddress()))
                    .toList();
                return new Building(address, goodsEntities.size(), goods);
            }).toList();
        // 상품 총 수 계산
        int total = buildings.stream().mapToInt(Building::totalGoods).sum();

        return new GoodsResponse(area.get().getAreaName(), total, buildings);
    }

    @Transactional(readOnly = true)
    public SortedGoodsResponse getSortedGoods(Long workerId) {
        //배송 기사 조회
        Optional<WorkerEntity> worker = workerRepository.findById(workerId);
        if (worker.isEmpty()) {
            throw new CommonException(ErrorCode.USER_NOT_FOUND);
        }

        //배송 기사의 구역 조회
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
            null, null
        )));
    }

    @Transactional(readOnly = true)
    public GoodsCountResponse getGoodsCount() {
        return new GoodsCountResponse(
            goodsRepository.countAllGoodsByCreatedAtIsToday(),
            goodsRepository.countStoredGoodsByCreatedAtIsToday(),
            goodsRepository.countLoadedGoodsByCreatedAtIsToday()
        );
    }
}
