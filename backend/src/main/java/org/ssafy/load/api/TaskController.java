package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.ssafy.load.application.TaskService;
import org.ssafy.load.common.dto.Response;
import org.ssafy.load.dto.request.LoadResultRequest;
import org.ssafy.load.dto.response.LoadTaskResponse;

@RestController
@RequiredArgsConstructor
@RequestMapping("/load")
public class TaskController {

    private final TaskService taskService;

    @GetMapping("/task")
    public Response<LoadTaskResponse> getLoadingTask() {
        LoadTaskResponse loadTaskResponse = taskService.getLoadingTask();
        return Response.success(loadTaskResponse);
    }

    @PostMapping("/task/result")
    public Response<Void> LoadResultRegist(@RequestBody LoadResultRequest loadResultRequest) {
        taskService.LoadResultRegist(loadResultRequest);
        return Response.success();
    }
}
