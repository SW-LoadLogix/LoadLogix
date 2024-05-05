package org.ssafy.load.application;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
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
