/**
 * APIResponse
 */
import com.fasterxml.jackson.annotation.JsonProperty;

public class APIResponse<T> {

    @JsonProperty("result_code")
    private String resultCode;
    private T result;

    public String getResultCode() {
        return resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }

}