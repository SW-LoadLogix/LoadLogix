package org.ssafy.load.common.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "User not founded"),
    ARTICLE_NOT_FOUND(HttpStatus.NOT_FOUND, "Article not founded"),
    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "Token is invalid"),
    EXPIRED_TOKEN(HttpStatus.UNAUTHORIZED, "Token is expired"),
    INVALID_PERMISSION(HttpStatus.UNAUTHORIZED, "Permission is invalid"),
    INVALID_REQUEST(HttpStatus.BAD_REQUEST, "Request is invalid"),
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "Internal Server error");

    final private HttpStatus status;
    final private String message;
}
