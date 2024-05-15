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

        if (randomValue > 0) {
            System.out.println("보낼 데이터 생성중");
            //보낼 데이터 생성

            /**
             * {"resultCode":"SUCCESS",
             * "result":{"task_id":11095,"building_id_order":[272,273,275,274,278,276,280],
             * "car":{"max_weight":1000000,"width":150,"height":150,"depth":200},
             * "goods":[
             * {"goods_id":6132,"building_id":276,"type":"L5","weight":27},
             * {"goods_id":6133,"building_id":274,"type":"L5","weight":503},
             * {"goods_id":6140,"building_id":274,"type":"L6","weight":877},
             * {"goods_id":6145,"building_id":276,"type":"L4","weight":715},
             * {"goods_id":6158,"building_id":275,"type":"L4","weight":330},
             * {"goods_id":6161,"building_id":274,"type":"L5","weight":653},
             * {"goods_id":6166,"building_id":275,"type":"L3","weight":82},
             * {"goods_id":6182,"building_id":273,"type":"L5","weight":310},
             * {"goods_id":6185,"building_id":280,"type":"L6","weight":448},
             * {"goods_id":6186,"building_id":273,"type":"L4","weight":563},
             * {"goods_id":6192,"building_id":278,"type":"L5","weight":162},
             * {"goods_id":6196,"building_id":276,"type":"L6","weight":205}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ]}}
             */
            TaskData taskData = new TaskData(
                    123,
                    new Car(150, 150, 200, 1000000),
                    Arrays.asList(272,273,275,274,278,276,280),
                    new ArrayList<GoodsItem>() {
                        {
                            add(new GoodsItem(6132, "L5", 27, 276));
                            add(new GoodsItem(6133, "L5", 503, 274));
                            add(new GoodsItem(6140, "L6", 877, 274));
                            add(new GoodsItem(6145, "L4", 715, 276));
                            add(new GoodsItem(6158, "L4", 330, 275));
                            add(new GoodsItem(6161, "L5", 653, 274));
                            add(new GoodsItem(6166, "L3", 82, 275));
                            add(new GoodsItem(6182, "L5", 310, 273));
                            add(new GoodsItem(6185, "L6", 448, 280));
                            add(new GoodsItem(6186, "L4", 563, 273));
                            add(new GoodsItem(6192, "L5", 162, 278));
                            add(new GoodsItem(6196, "L6", 205, 276));

                        }
                    }
            );
            // ObjectMapper를 사용하여 JSON 문자열로 직렬화

            json = gson.toJson(new jsonResponse("SUSSESS", taskData));
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
    public class jsonResponse {
        private String resultCode;
        private TaskData result;
    }

    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public class TaskData {
        private int task_id;
        private Car car;
        private List<Integer> building_id_order;
        private List<GoodsItem> goods;

    }

    @Getter
    @Setter
    @AllArgsConstructor
    public class Car {
        private int width;
        private int height;
        private int depth;
        private int max_weight;

    }

    @Getter
    @Setter
    @AllArgsConstructor
    public static class GoodsItem {
        private int goods_id;
        private String type;
        private int weight;
        private int building_id;

    }
}

