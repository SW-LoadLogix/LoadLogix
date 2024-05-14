package org.ssafy.load.common.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Response<T> {
    @JsonProperty("result_code") private String resultCode;
    private T result;

    public static Response<Void> success() {
        return new Response<Void>("SUCCESS", null);
    }

    public static <T> Response<T> success(T result) {
        return new Response<>("SUCCESS", result);
    }

    public static Response<Void> error(String errorCode) {
        return new Response<>(errorCode, null);
    }
}
