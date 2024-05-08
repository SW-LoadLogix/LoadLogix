package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.ssafy.load.application.AddressService;
import org.ssafy.load.application.DeliveryService;
import org.ssafy.load.application.GoodsService;
import org.ssafy.load.application.LoadTaskService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.CreateGoodsRequest;
import org.ssafy.load.dto.request.ReadyRequest;

import java.util.List;
import org.ssafy.load.dto.response.CreateGoodsResponse;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final AddressService addressService;
    public final DeliveryService deliveryService;
    public final LoadTaskService loadTaskService;
    public final GoodsService goodsService;

    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(addressService.getAreaAndBuildingCount());
    }

    @PutMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyRequest readyRequest) {
        loadTaskService.setReadyCompletedArea(readyRequest);
        return Response.success();
    }

    @GetMapping("/conveyorLines")
    public Response<List<Integer>> getConveyorLine() {
        return Response.success(deliveryService.getConveyorLine());
    }

    @PostMapping("/goods")
    public Response<CreateGoodsResponse> createGoods(@RequestBody CreateGoodsRequest createGoodsRequest){
        return Response.success(goodsService.createGoods(createGoodsRequest));
    }
}