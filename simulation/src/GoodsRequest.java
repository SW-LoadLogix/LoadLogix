/**
 * GoodsRequest
 */
public class GoodsRequest implements Serializable{
    private long agentId;
    private int type;
    private int weight;
    private long buildingId;
    private String detailAddress;

    public GoodsRequest() {}

    public long getAgentId() {
        return agentId;
    }
    public int getType() {
        return type;
    }
    public int getWeight() {
        return weight;
    }

    public long getBuildingId() {
        return buildingId;
    }
    public String getDetailAddress() {
        return detailAddress;
    }

    public static GoodsRequest from(Goods agent) {
        GoodsRequest dto = new GoodsRequest();
        dto.type = agent.type;
        dto.weight = agent.weight;
        dto.agentId = agent.agentId;
        dto.buildingId = agent.buildingId;
        dto.detailAddress = agent.detailAddress;
        return dto;
    }

}