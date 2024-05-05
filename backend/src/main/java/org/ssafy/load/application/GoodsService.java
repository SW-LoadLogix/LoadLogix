package org.ssafy.load.application;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.*;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.domain.WorkerEntity;
import org.ssafy.load.dto.Building;
import org.ssafy.load.dto.Goods;
import org.ssafy.load.dto.response.GoodsResponse;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class GoodsService {

    private final WorkerRepository workerRepository;
    private final AreaRepository areaRepository;
    private final BuildingRepository buildingRepository;
    private final GoodsRepository goodsRepository;

    public GoodsResponse getOriginGoods(Long workerId) {
        //배송 기사 조회
        Optional<WorkerEntity> worker = workerRepository.findById(workerId);
        if (worker.isEmpty())
            throw new CommonException(ErrorCode.USER_NOT_FOUND);

        //배송 기사의 구역 조회
        Optional<AreaEntity> area = areaRepository.findById(worker.get().getArea().getId());
        if (area.isEmpty())
            throw new CommonException(ErrorCode.AREA_NOT_FOUND);

        //구역에 해당된 빌딩 id 조회
        List<Long> buildingIds = buildingRepository.findIdsByAreaId(area.get().getId());
        if (buildingIds.isEmpty())
            throw new CommonException(ErrorCode.BUILDING_NOT_FOUND);

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
                            .append(goodsEntities.getFirst().getBuilding().getZibunSub() + " ")
                            .append(goodsEntities.getFirst().getBuilding().getBuildingMain() + " ")
                            .append(goodsEntities.getFirst().getBuilding().getBuildingSub());
                    String address = sb.toString();
                    List<Goods> goods = goodsEntities.stream()
                            .map(g -> new Goods(
                                    g.getId(),
                                    String.valueOf(g.getBoxType().getType()),
                                    g.getWeight(),
                                    g.getDetailAddress() + " " + g.getDetailJuso()))
                            .toList();
                    return new Building(address, goodsEntities.size(), goods);
                }).toList();
        // 상품 총 수 계산
        int total = buildings.stream().mapToInt(Building::totalGoods).sum();

        return new GoodsResponse(area.get().getAreaName(), total, buildings);
    }
}
