package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.AreaReadStatusService;
import org.ssafy.load.application.BuildingAddressService;
import org.ssafy.load.application.DeliveryService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.response.ReadyAreaRequest;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final BuildingAddressService buildingAddressService;
    public final DeliveryService deliveryService;
    public final AreaReadStatusService areaReadStatusService;



    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(buildingAddressService.getAreaAndBuildingCount());
    }

    @GetMapping("/ready")
    public Response<Void> setReadyCompletedArea(@RequestBody ReadyAreaRequest readyAreaRequest) {
        System.out.println(readyAreaRequest.toString());
        areaReadStatusService.setReadyCompletedArea(readyAreaRequest);
        return Response.success();
    }

    @GetMapping("/conveyorLines")
    public Response<List<Integer>> getConveyorLine() {
        return Response.success(deliveryService.getConveyorLine());
    }

}
