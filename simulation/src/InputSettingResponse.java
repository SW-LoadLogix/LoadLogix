/**
 * InputSettingResponse
 */
public class InputSettingResponse implements Serializable {

    private List<Integer> goodsCountPerArea;
    private List<AreaAndBuilding> areaAndBuilding;
    private long agentId;

    public InputSettingResponse() {}

    public List<Integer> getGoodsCountPerArea(){
        return goodsCountPerArea;
    }
    public List<AreaAndBuilding> getAreaAndBuilding(){
        return areaAndBuilding;
    }
    public long getAgentId() {
        return agentId;
    }

}