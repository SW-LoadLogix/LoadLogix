/**
 * LoadStartResponse
 */
public class LoadStartResponse implements Serializable {

    private int areaId;
    private int conveyNo;
    private boolean readyVehicle;
    private List<Long> agentIds;

    public LoadStartResponse() {}

    public LoadStartResponse(int areaId, int conveyNo, boolean readyVehicle, List<Long> agentIds) {
        this.areaId = areaId;
        this.conveyNo = conveyNo;
        this.readyVehicle = readyVehicle;
        this.agentIds = agentIds;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public int getConveyNo() {
        return conveyNo;
    }

    public void setConveyNo(int conveyNo) {
        this.conveyNo = conveyNo;
    }
    public boolean getReadyVehicle() {
        return readyVehicle;
    }

    public void setReadyVehicle(boolean readyVehicle) {
        this.readyVehicle = readyVehicle;
    }
    public List<Long> getAgentIds() {
        return this.agentIds;
    }
    public void setAgentIds(List<Long> agentIds) {
        this.agentIds = agentIds;
    }

}