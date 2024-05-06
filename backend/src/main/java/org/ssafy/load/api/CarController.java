package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.ssafy.load.application.CarService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.CarChangeRequest;
import org.ssafy.load.dto.response.CarResponse;
import org.ssafy.load.security.JwtTokenProvider;

@RequiredArgsConstructor
@RestController
@RequestMapping("/car")
public class CarController {

    private final JwtTokenProvider jwtTokenProvider;
    private final CarService carService;

    @PutMapping("/change")
    public Response<CarResponse> updateCarSize(@RequestHeader(name = "Authorization") String token,
                                               @RequestBody CarChangeRequest carChangeRequest
    ) {
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(carService.updateCarSize(carChangeRequest, workerId));
    }
}
