package org.ssafy.load.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.dto.Coordinate;

@Component
@RequiredArgsConstructor
@Slf4j
public class PathTimeCal {

    @Value("${kakao.api.key}")
    private String kakaoAPIKey;

    private final RestTemplateBuilder restTemplateBuilder;

    public int getPathTime(String sourceAddress, String desAddress) {
        Coordinate sourceCoordinate = toCoordinate(sourceAddress);
        Coordinate desCoordinate = toCoordinate(desAddress);
        return calculatePathTime(sourceCoordinate.longitude(), sourceCoordinate.latitude(),
                desCoordinate.longitude(), desCoordinate.latitude());
    }

    public int calculatePathTime(double originLongitude, double originLatitude, double desLongitude, double desLatitude) {
        RestTemplate restTemplate = restTemplateBuilder.build();
        String url = "https://apis-navi.kakaomobility.com/v1/directions?" +
                "origin={originLongitude},{originLatitude}&destination={desLongitude},{desLatitude}";

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        httpHeaders.set("Authorization", "KakaoAK " + kakaoAPIKey);

        HttpEntity<String> requestEntity = new HttpEntity<>("", httpHeaders);
        ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, String.class,
                originLatitude, originLongitude, desLatitude, desLongitude);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(responseEntity.getBody());

            //출발지와 도착지가 5m 이내로 설정된 경우
            if(jsonNode.get("routes").get(0).get("result_code").asInt() == 104)  {
                return 0;
            }
            return jsonNode.get("routes").get(0).get("summary").get("duration").asInt();
        } catch (Exception e) {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Coordinate toCoordinate(String address) {
        RestTemplate restTemplate = restTemplateBuilder.build();
        String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + address;

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        httpHeaders.set("Authorization", "KakaoAK " + kakaoAPIKey);

        HttpEntity<String> requestEntity = new HttpEntity<>("", httpHeaders);
        ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, String.class);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(responseEntity.getBody());
            jsonNode = jsonNode.get("documents").get(0);
            double x = jsonNode.get("x").asDouble();
            double y = jsonNode.get("y").asDouble();
            return new Coordinate(x, y);
        }
        catch (Exception e) {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
