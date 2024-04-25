/**
 * GoodsResponse
 */	
public class GoodsResponse {
	
	private String resultCode;
	private List<GoodsDto> result;
	
	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public List<GoodsDto> getResult() {
		return result;
	}

	public void setResult(List<GoodsDto> result) {
		this.result = result;
	}
	
}