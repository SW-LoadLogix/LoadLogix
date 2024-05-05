package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.BuildingRegistRequest;

@RestController
@RequiredArgsConstructor
@RequestMapping("/Building")
public class PathTimeController {

    @PostMapping
    public Response<Void> registBuilding(BuildingRegistRequest buildingRegistRequest) {
        return Response.success();
    }
}
