package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.GoodsService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.response.GoodsTotalResponse;
import org.ssafy.load.dto.response.goods.GoodsListResponse;
import org.ssafy.load.dto.response.goods.SortedGoodsResponse;
import org.ssafy.load.security.JwtTokenProvider;

@RequiredArgsConstructor
@RestController
@RequestMapping("/goods")
public class GoodsController {

    public final JwtTokenProvider jwtTokenProvider;
    private final GoodsService goodsService;

    @GetMapping("/origin")
    public Response<GoodsListResponse> getOriginGoods(@RequestHeader(name="Authorization") String token){
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(goodsService.getOriginGoods(workerId));
    }

    @GetMapping("/loads")
    public Response<SortedGoodsResponse> getSortedGoods(@RequestHeader(name="Authorization") String token){
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(goodsService.getSortedGoods(workerId));
    }

    @GetMapping("/total")
    public Response<GoodsTotalResponse> getDayLoadedGoodsCount(@RequestHeader(name="Authorization") String token){
        Long workerId = jwtTokenProvider.getId(token);
        return Response.success(goodsService.getDayLoadedGoodsCount(workerId));
    }
}
