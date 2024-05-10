package org.ssafy.load.api;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.AdminService;
import org.ssafy.load.application.AreaService;
import org.ssafy.load.application.GoodsService;
import org.ssafy.load.application.WorkerService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.AreaSettingRequest;
import org.ssafy.load.dto.request.LoginRequest;
import org.ssafy.load.dto.response.BoxTypeResponse;
import org.ssafy.load.dto.response.DayGoodsCountResponse;
import org.ssafy.load.dto.response.GoodsCountResponse;
import org.ssafy.load.dto.response.GoodsOutputResponse;
import org.ssafy.load.dto.response.GoodsResponse;
import org.ssafy.load.dto.response.LoginResponse;
import org.ssafy.load.dto.response.WorkerResponse;
import org.ssafy.load.security.JwtTokenProvider;

@RequiredArgsConstructor
@RestController
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final GoodsService goodsService;
    private final WorkerService workerService;
    private final AreaService areaService;

    @PostMapping("/login")
    public Response<LoginResponse> login(@RequestBody LoginRequest loginRequest) {
        return Response.success(adminService.login(loginRequest));
    }

    @GetMapping("/good-counts")
    public Response<GoodsCountResponse> getGoodsCount() {
        return Response.success(goodsService.getGoodsCount());
    }

    @GetMapping("/day-counts")
    public Response<List<DayGoodsCountResponse>> getDayGoodsCount() {
        return Response.success(goodsService.getDayGoodsCount());
    }

    @GetMapping("/goods")
    public Response<List<GoodsOutputResponse>> getGoodsList() {
        return Response.success(goodsService.getGoodsList());
    }

    @GetMapping("/loads")
    public Response<List<GoodsOutputResponse>> getLoadedGoodsList() {
        return Response.success(goodsService.getLoadedGoodsList());
    }

    @GetMapping("/types")
    public Response<List<BoxTypeResponse>> getBoxTypeCount() {
        return Response.success(goodsService.getBoxTypeCount());
    }

    @GetMapping("/workers")
    public Response<List<WorkerResponse>> getWorkerList() {
        return Response.success(workerService.getWorkerList());
    }

    @PostMapping("/settings")
    public Response<String> setAreaCount(@RequestBody AreaSettingRequest areaSettingRequest) {
        return Response.success(areaService.setAreaCount(areaSettingRequest));
    }
}
