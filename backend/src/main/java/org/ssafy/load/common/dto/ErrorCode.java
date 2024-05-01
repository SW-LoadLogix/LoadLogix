package org.ssafy.load.common.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "User not founded"),
    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "Token is invalid"),
    EXPIRED_TOKEN(HttpStatus.UNAUTHORIZED, "Token is expired"),
    INVALID_REQUEST(HttpStatus.BAD_REQUEST, "Request is invalid"),
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "Internal Server error"),
    EMPTY_TABLE(HttpStatus.INTERNAL_SERVER_ERROR, "Empty db table"),
    CONVEYOR_NOT_FOUND(HttpStatus.NOT_FOUND, "Conveyor not founded");

    final private HttpStatus status;
    final private String message;
}
