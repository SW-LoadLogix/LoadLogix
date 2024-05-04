package org.ssafy.load.api;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.google.gson.Gson;
import java.util.*;

@RestController
@RequestMapping("/load")
public class LoadController {
    @GetMapping
    public ResponseEntity<String> streamEvents() {
        //json 객체 생성
        Gson gson = new Gson();
        String json = "";

        //테스트 코드 -> 일정 확률로 객체 전달 or 빈 객체 전달
        double randomValue = Math.random();

        if (randomValue > 0.3) {
            System.out.println("보낼 데이터 생성중");
            //보낼 데이터 생성
            TaskData taskData = new TaskData(
                    123,
                    new Car(170, 370, 210, 400),
                    Arrays.asList(4, 5, 6, 7),
                    new ArrayList<GoodsItem>() {
                        {
                            add(new GoodsItem(1, "L1", 100, 7));
                            add(new GoodsItem(2, "L1", 200, 7));
                        }
                    }
            );
            // ObjectMapper를 사용하여 JSON 문자열로 직렬화

            json = gson.toJson(taskData);
        } else {
            System.out.println("빈 데이터 생성중");
            Object emptyObject = new Object();
            json = gson.toJson(emptyObject);
        }
        // 생성된 JSON 데이터를 클라이언트에게 전송
        System.out.println(json);
        return ResponseEntity.ok(json);

    }

    @PostMapping
    public void loadFinish(@RequestBody String loadResponse) {
        System.out.println("Received JSON: " + loadResponse);
    }

    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public class TaskData {
        private int taskId;
        private Car car;
        private List<Integer> buildingIdOrder;
        private List<GoodsItem> goods;

    }

    @Getter
    @Setter
    @AllArgsConstructor
    public class Car {
        private int width;
        private int height;
        private int depth;
        private int weight;

    }

    @Getter
    @Setter
    @AllArgsConstructor
    public static class GoodsItem {
        private int goodsId;
        private String type;
        private int weight;
        private int buildingId;

    }
}

