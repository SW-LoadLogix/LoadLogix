package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.GoodsRepository;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.dto.Goods;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class GoodsService {
    private final GoodsRepository goodsRepository;

    public List<Goods> getGoods(){
        System.out.println(goodsRepository);
        List<GoodsEntity> goodsEntities = goodsRepository.findAll();
        System.out.println(goodsEntities);
        if(goodsEntities.isEmpty()){
            throw new CommonException(ErrorCode.EMPTY_TABLE);
        }
        List<Goods> goods = new ArrayList<>();
        for(GoodsEntity goodsEntity : goodsEntities){
            System.out.println(Goods.from(goodsEntity));
            goods.add(Goods.from(goodsEntity));
        }
        return goods;
    }
}
