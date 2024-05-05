package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.ssafy.load.application.AddressService;
import org.ssafy.load.application.DeliveryService;
import org.ssafy.load.application.ReadyStatusService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.ReadyAreaRequest;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final AddressService addressService;
    public final DeliveryService deliveryService;
    public final ReadyStatusService readyStatusService;



    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(addressService.getAreaAndBuildingCount());
    }

    @PutMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyAreaRequest readyAreaRequest) {
        readyStatusService.setReadyCompletedArea(readyAreaRequest);
        return Response.success();
    }

    @GetMapping("/conveyorLines")
    public Response<List<Integer>> getConveyorLine() {
        return Response.success(deliveryService.getConveyorLine());
    }

}
