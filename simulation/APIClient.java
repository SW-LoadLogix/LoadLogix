import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class APIClient {

    private final String SERVER_URL = "http://localhost:8080/api/simulation";

    public ArrayList<BuildingDto> getBuildingJuso() throws Exception{
        String url = SERVER_URL + "";
        String method = "GET";
        StringBuffer response = getResponse(url, method);

        ObjectMapper objectMapper = new ObjectMapper();
        APIResponse<BuildingDto> apiResponse = objectMapper.readValue(response.toString(), new TypeReference<APIResponse<BuildingDto>>() {});

        String resultCode = apiResponse.getResultCode();
        ArrayList<BuildingDto> result = (ArrayList) apiResponse.getResult();

        return result;

    }

    public List<GoodsDto> getGoods() throws Exception {
        String url = SERVER_URL + "/goods";
        String method = "GET";
        StringBuffer response = getResponse(url, method);

        // JSON을 ApiResponse 객체로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        APIResponse<GoodsDto> apiResponse = objectMapper.readValue(response.toString(), APIResponse.class);

        String resultCode = apiResponse.getResultCode();
        List<GoodsDto> result = apiResponse.getResult();

        return result;
    }

    public StringBuffer getResponse(String url, String method) throws Exception{

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        // HTTP 요청 메소드 설정 (GET 방식)
        con.setRequestMethod("GET");

        // 응답 코드 받기
        int responseCode = con.getResponseCode();
        //System.out.println("Response Code: " + responseCode);

        // 응답 내용 받기
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // 응답 내용 출력
        //System.out.println("Response: " + response.toString());

        return response;
    }
}
