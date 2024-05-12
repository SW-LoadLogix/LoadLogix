package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.ssafy.load.application.AddressService;
import org.ssafy.load.application.GoodsService;
import org.ssafy.load.application.LoadTaskService;
import org.ssafy.load.application.SseService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.GoodsCreateRequest;
import org.ssafy.load.dto.request.ReadyRequest;

import java.util.List;
import org.ssafy.load.dto.response.GoodsCreateResponse;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final AddressService addressService;
    public final LoadTaskService loadTaskService;
    public final SseService sseService;
    public final GoodsService goodsService;

    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(addressService.getAreaAndBuildingCount());
    }

    @PostMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyRequest readyRequest) {
        loadTaskService.setReadyCompletedArea(readyRequest);
        return Response.success();
    }

    @GetMapping(value = "/start", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter streamSse() {return sseService.createEmitter("1");
    }

    @PostMapping("/goods")
    public Response<Void> createGoods(@RequestBody GoodsCreateRequest goodsCreateRequest){
        goodsService.createGoods(goodsCreateRequest);
        return Response.success();
    }
}