package org.ssafy.load.application;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.dto.request.AreaSettingRequest;
import org.ssafy.load.dto.response.AreaResponse;

@Service
@RequiredArgsConstructor
@Transactional
public class AreaService {

    private final AreaRepository areaRepository;

    public void setAreaCount(List<AreaSettingRequest> requests) {
        for (AreaSettingRequest areaSettingRequest : requests) {
            AreaEntity areaEntity = areaRepository.findById(areaSettingRequest.areaId())
                    .orElseThrow(() -> new CommonException(ErrorCode.AREA_NOT_FOUND));
            areaEntity.updateArea(areaSettingRequest);
            areaRepository.save(areaEntity);
        }
    }

    public List<AreaResponse> getAreaInfo(){
        List<AreaEntity> areaEntityList = areaRepository.findAll();
        List<AreaResponse> areaResponses = new ArrayList<>();
        for(AreaEntity areaEntity : areaEntityList){
            areaResponses.add(AreaResponse.of(areaEntity.getId(), areaEntity.getAreaName(),areaEntity.getConveyNo(), areaEntity.getCount()));
        }
        return areaResponses;
    }
}
