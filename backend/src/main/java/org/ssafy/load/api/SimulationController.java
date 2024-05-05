package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.ssafy.load.application.AddressService;
import org.ssafy.load.application.DeliveryService;
import org.ssafy.load.application.ReadyStatusService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.ReadyAreaRequest;
import reactor.core.publisher.Flux;

import java.time.Duration;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final AddressService addressService;
    public final DeliveryService deliveryService;
    public final ReadyStatusService areaReadyStatusService;


    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(addressService.getAreaAndBuildingCount());
    }

    @PutMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyAreaRequest readyAreaRequest) {
        areaReadyStatusService.setReadyCompletedArea(readyAreaRequest);
        return Response.success();
    }

    @GetMapping(value = "/start", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<Integer> streamEvents() {
        return Flux.interval(Duration.ofSeconds(3))
                .map(sequence -> areaReadyStatusService.getReadyStatus());
    }

    @GetMapping("/conveyorLines")
    public Response<List<Integer>> getConveyorLine() {
        return Response.success(deliveryService.getConveyorLine());
    }
}