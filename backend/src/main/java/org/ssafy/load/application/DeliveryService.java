package org.ssafy.load.application;

import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;

@Service
@RequiredArgsConstructor
public class DeliveryService {

    public List<Integer> getConveyorLine() {
        List<Integer> conveyorLine = new ArrayList<>();
        conveyorLine.add(2);
//        if (conveyorLine < 1 || conveyorLine > 4) {
//            throw new CommonException(ErrorCode.CONVEYOR_NOT_FOUND);
//        }
        return conveyorLine;
    }
}
