package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.BuildingService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.BuildingRegistRequest;

@RestController
@RequiredArgsConstructor
@RequestMapping("/building")
public class BuildingController {
    private final BuildingService buildingService;

    @PostMapping
    public Response<Void> registBuilding(@RequestBody BuildingRegistRequest buildingRegistRequest) {
        buildingService.registBuilding(buildingRegistRequest);
        return Response.success();
    }
}
