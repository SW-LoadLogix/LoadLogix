package org.ssafy.load.application;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ssafy.load.dao.AreaRepository;
import org.ssafy.load.domain.AreaEntity;
import org.ssafy.load.dto.request.AreaSettingRequest;

@Service
@RequiredArgsConstructor
@Transactional
public class AreaService {

    private final AreaRepository areaRepository;

    public String setAreaCount(AreaSettingRequest areaSettingRequest) {

        for (int i = 0; i < areaSettingRequest.count().size(); i++) {
            AreaEntity area = areaRepository.findById(i + 1).get();
            area.updateArea(areaSettingRequest.count().get(i));
        }
        return "SUCCESS";
    }
}
