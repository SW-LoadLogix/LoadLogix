package org.ssafy.load.application;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.ssafy.load.dto.response.LoadStartResponse;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class SseService {
    private Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();

    public SseEmitter createEmitter(String clientId) {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE); // 타임아웃을 무기한으로 설정
        emitter.onCompletion(() -> emitters.remove(clientId));
        emitter.onTimeout(() -> {
            emitter.complete();
            emitters.remove(clientId);
        });
        emitters.put(clientId, emitter);
        return emitter;
    }

    public void sendEvent(String clientId, LoadStartResponse data) {
        SseEmitter emitter = emitters.get(clientId);
        if (emitter != null) {
            try {
                emitter.send(data);
                // emitter.complete(); // 이벤트 전송 후 완료를 호출하지 않음
            } catch (IOException e) {
                emitter.completeWithError(e);
            }
        } else {
            System.out.println("SseEmitter for clientId " + clientId + " is not available");
        }
    }
}