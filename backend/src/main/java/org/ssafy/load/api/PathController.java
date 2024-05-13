package org.ssafy.load.api;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.PathService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.response.PathResponse;
import org.ssafy.load.security.JwtTokenProvider;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/path")
public class PathController {
    private final PathService pathService;
    private final JwtTokenProvider jwtTokenProvider;

    @GetMapping
    public Response<List<PathResponse>> getDeliveryPath(@RequestHeader(name="Authorization") String token) {
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(pathService.getDeliveryPath(workerId));
    }
}
