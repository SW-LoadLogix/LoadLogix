package org.ssafy.load.dto.response;

public record StatusResponse(
        boolean isReady,
        String message
) {
    public static StatusResponse of(boolean isReady, String message){
        return new StatusResponse(isReady, message);
    }
}
