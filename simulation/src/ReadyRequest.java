/**
 * ReadyRequest
 */
public class ReadyRequest implements Serializable{

    private int areaId;
    private List<Long> agentIds;

    public ReadyRequest() {}

    public ReadyRequest(int areaId, List<Long> agentIds) {
        this.areaId = areaId;
        this.agentIds = agentIds;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public List<Long> getAgentIds() {
        return agentIds;
    }

    public void setAgentIds(List<Long> agentIds) {
        this.agentIds = agentIds;
    }
}