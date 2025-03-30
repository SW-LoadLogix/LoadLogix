import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class APIClient {

    private final String SERVER_URL = "http://loadlogix.store:8081/api/simulation";
    //private final String SERVER_URL = "http://localhost:8081/api/simulation";


    private static APIClient instance = new APIClient();
    public static APIClient getInstance() {
        return instance;
    }
    public void postGoods(Goods goods) throws Exception{
        String url = SERVER_URL + "/goods";
        String method = "POST";

        GoodsRequest goodsRequest = GoodsRequest.from(goods);
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonRequestBody = objectMapper.writeValueAsString(goodsRequest);

        StringBuffer response = getResponse(url, method, jsonRequestBody);

        APIResponse<Integer> apiResponse = objectMapper.readValue(response.toString(), new TypeReference<APIResponse<Integer>>() {});

        String resultCode = apiResponse.getResultCode();


    }

    public void setReadyCompletedArea(int areaId, List<Long> agentIds) throws Exception{

        System.out.println(agentIds);

        String url = SERVER_URL + "/ready";
        String method = "POST";

        ReadyRequest requestBody = new ReadyRequest(areaId, agentIds);
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonRequestBody = objectMapper.writeValueAsString(requestBody);

        StringBuffer response = getResponse(url, method, jsonRequestBody);

        APIResponse<Integer> apiResponse = objectMapper.readValue(response.toString(), new TypeReference<APIResponse<Integer>>() {});

        String resultCode = apiResponse.getResultCode();

    }

    public InputSettingResponse getInputSettingInfo() throws Exception{
        String url = SERVER_URL + "";
        String method = "GET";
        StringBuffer response = getResponse(url, method, null);

        ObjectMapper objectMapper = new ObjectMapper();
        APIResponse<InputSettingResponse> apiResponse = objectMapper.readValue(response.toString(), new TypeReference<APIResponse<InputSettingResponse>>() {});

        String resultCode = apiResponse.getResultCode();
        InputSettingResponse result = (InputSettingResponse) apiResponse.getResult();
        return result;

    }

    public StringBuffer getResponse(String url, String method, String jsonRequestBody) throws Exception{

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        con.setRequestMethod(method);

        if ("PUT".equals(method) || "POST".equals(method)) {
            con.setDoOutput(true);
            con.setRequestProperty("Content-Type", "application/json; utf-8");

            if (jsonRequestBody != null) {
                try (OutputStream os = con.getOutputStream()) {
                    byte[] input = jsonRequestBody.getBytes("utf-8");
                    os.write(input, 0, input.length);
                }
            }
        }

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
