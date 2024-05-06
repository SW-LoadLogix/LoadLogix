package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.GoodsRepository;
import org.ssafy.load.dao.LoadTaskRepository;
import org.ssafy.load.domain.GoodsEntity;
import org.ssafy.load.domain.LoadTaskEntity;
import org.ssafy.load.dto.response.LoadTaskResponse;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final PathService pathService;
    private LoadTaskRepository loadTaskRepository;
    private GoodsRepository goodsRepository;

    public LoadTaskResponse getLoadingTask() {
        Optional<LoadTaskEntity> loadTaskEntityOptional = loadTaskRepository.findFirstByCompleteIsFalseOrderByCreatedAt();

        if(loadTaskEntityOptional.isEmpty()) {
            return null;
        }

        List<GoodsEntity> goodsEntityList = new ArrayList<>();
        

        return null;
    }



}
