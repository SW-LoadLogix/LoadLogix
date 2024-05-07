package org.ssafy.load.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.application.TaskService;
import org.ssafy.load.common.dto.Response;
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

    
}
