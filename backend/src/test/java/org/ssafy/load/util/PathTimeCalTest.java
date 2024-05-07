package org.ssafy.load.util;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class PathTimeCalTest {

    @Autowired
    PathTimeCal pathTimeCal;

    @Test
    void pathTimeCalTest() {
        long duration = pathTimeCal.getPathTime("대전광역시 동구 삼성동 331-1", "대전광역시 동구 삼성동 331-10");
        System.out.println(duration);
    }

}