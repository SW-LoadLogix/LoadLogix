package org.ssafy.load.api;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.GoodsService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.response.GoodsResponse;
import org.ssafy.load.dto.SortedGoods;
import org.ssafy.load.dto.response.SortedGoodsResponse;
import org.ssafy.load.security.JwtTokenProvider;

@RequiredArgsConstructor
@RestController
@RequestMapping("/goods")
public class GoodsController {

    public final JwtTokenProvider jwtTokenProvider;
    private final GoodsService goodsService;

    @GetMapping("/origin")
    public Response<GoodsResponse> getOriginGoods(@RequestHeader(name="Authorization") String token){
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(goodsService.getOriginGoods(workerId));
    }

    @GetMapping("/loads")
    public Response<SortedGoodsResponse> getSortedGoods(@RequestHeader(name="Authorization") String token){
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(goodsService.getSortedGoods(workerId));
    }
}
