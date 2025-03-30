/**
 * SSEListener
 */
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import com.fasterxml.jackson.databind.ObjectMapper;


public class SSEListener implements Runnable {
    private String sseUrl;
    private Main mainInstance;

    public SSEListener(Main mainInstance) {
        this.sseUrl = "http://loadlogix.store:8081/api/simulation/start";
        //this.sseUrl = "http://localhost:8081/api/simulation/start";

        this.mainInstance = mainInstance;
    }


    @Override
    public void run() {
        try {
            URL url = new URL(sseUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "text/event-stream");

            int responseCode = conn.getResponseCode();
            if (responseCode != HttpURLConnection.HTTP_OK) {
                // System.out.println("Server returned HTTP response code: " + responseCode + " for URL: " + sseUrl);
                return;
            }


            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("data:")) {
                    String response = line.substring(5).trim();
                    ObjectMapper objectMapper = new ObjectMapper();

                    LoadStartResponse loadStartResponse = objectMapper.readValue(response.toString(), LoadStartResponse.class);

                    //LoadStartRequest data = objectMapper.readValue(json, LoadStartRequest.class);

                    System.out.println("Received AreaData: area_id=" + loadStartResponse.getAreaId() + ", conveyNo=" + loadStartResponse.getConveyNo()+", vehicle=" + loadStartResponse.getReadyVehicle()+ ",agentIds="+loadStartResponse.getAgentIds().toString());

                    // 차량 준비
                    if(loadStartResponse.getReadyVehicle()) {
                        mainInstance.readyVehicleToConvey[loadStartResponse.getConveyNo()] = true;
                    }
                    // 적재 시작
                    if(loadStartResponse.getAreaId()!=0) {
                        mainInstance.startPick(loadStartResponse);
                    }
                }
            }

            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}                    