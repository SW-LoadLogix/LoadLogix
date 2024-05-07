package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.ssafy.load.application.AddressService;
import org.ssafy.load.application.LoadTaskService;
import org.ssafy.load.application.SseService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.ReadyRequest;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final AddressService addressService;
    public final LoadTaskService loadTaskService;
    public final SseService sseService;


    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(addressService.getAreaAndBuildingCount());
    }

    @PutMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyRequest readyRequest) {
        loadTaskService.setReadyCompletedArea(readyRequest);
        return Response.success();
    }

//    @GetMapping(value = "/start", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
//    public Flux<LoadStartRequest> streamEvents() {
//        return Flux.interval(Duration.ofSeconds(3))
//                .map(sequence -> loadTaskService.getReadyStatus());
//    }

//    @GetMapping("/ready")
//    public SseEmitter streamSse() {
//        // 요청마다 새로운 SseEmitter 생성
//        SseEmitter emitter = new SseEmitter();
//
//        // 백그라운드 스레드에서 데이터 전송
//        new Thread(() -> {
//            try {
//                emitter.send();
//                emitter.complete();
//            } catch (Exception e) {
//                emitter.completeWithError(e);
//            }
//        }).start();
//
//        return emitter;
//    }
    @GetMapping("/ready")
    public SseEmitter streamSse() {
        return sseService.createEmitter();
    }

}