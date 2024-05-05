package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.BuildingService;
import org.ssafy.load.application.DeliveryService;
import org.ssafy.load.common.dto.Response;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/simulation")
public class SimulationController {

    public final BuildingService buildingService;
    public final DeliveryService deliveryService;


    @GetMapping
    public Response<List<Integer>> getAreaAndBuildingCount() {
        return Response.success(buildingService.getAreaAndBuildingCount());
    }

    @GetMapping("/conveyorLines")
    public Response<List<Integer>> getConveyorLine() {
        return Response.success(deliveryService.getConveyorLine());
    }

}
