package org.ssafy.load.dto.request.anylogic;

import java.util.List;

public record InputSettingResponse(
        List<Integer> goodsCountPerArea,
        List<AreaAndBuilding> areaAndBuilding
        ) {
    public static InputSettingResponse of(List<Integer> goodsCountPerArea, List<AreaAndBuilding> areaAndBuilding ){
        return new InputSettingResponse(goodsCountPerArea, areaAndBuilding);
    }
}
