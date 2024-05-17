package org.ssafy.load.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.ssafy.load.application.*;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.GoodsCreateRequest;
import org.ssafy.load.dto.request.ReadyRequest;

import java.util.List;

import org.ssafy.load.dto.request.anylogic.InputSettingResponse;
import org.ssafy.load.dto.response.GoodsCreateResponse;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final LoadTaskService loadTaskService;
    public final SseService sseService;
    public final GoodsService goodsService;
    public final BuildingService buildingService;

    @GetMapping
    public Response<InputSettingResponse> getAreaAndBuildingCount() {
        return Response.success(buildingService.getInputSettingInfo());
    }

    @PostMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyRequest readyRequest) {
        loadTaskService.setReadyCompletedArea(readyRequest);
        return Response.success();
    }

    @GetMapping(value = "/start", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter streamSse(HttpServletRequest request) {
        System.out.println("-----------------------SSE 연결 ------------------------");
        String clientIp = request.getRemoteAddr();
        String userAgent = request.getHeader("User-Agent");
        System.out.println("SSE 연결");
        System.out.println("클라이언트 IP: " + clientIp);
        System.out.println("User-Agent: " + userAgent);
        return sseService.createEmitter("1");
    }

    @PostMapping("/goods")
    public Response<Void> createGoods(@RequestBody GoodsCreateRequest goodsCreateRequest){
        goodsService.createGoods(goodsCreateRequest);
        return Response.success();
    }
}