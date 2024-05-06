package org.ssafy.load.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.ssafy.load.common.dto.Response;

@RestController
public class TaskController {

    @GetMapping
    public Response<Void> getLoadingTask() {
        return Response.success();
    }
}
