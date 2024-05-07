package org.ssafy.load.application;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.ssafy.load.dto.response.LoadStartResponse;

@Service
public class SseService {
    private SseEmitter sseEmitter;

    public SseEmitter createEmitter() {
        sseEmitter = new SseEmitter();
        return sseEmitter;
    }

    public void sendEvent(LoadStartResponse data) {

        // 요청마다 새로운 SseEmitter 생성
        SseEmitter emitter = new SseEmitter();

        // 백그라운드 스레드에서 데이터 전송
        new Thread(() -> {
            try {
                sseEmitter.send(data);
                sseEmitter.complete();

            } catch (Exception e) {
                sseEmitter.completeWithError(e);
            }
        }).start();
    }
}
