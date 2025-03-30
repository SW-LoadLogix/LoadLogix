/**
 * InitialInfo
 */
public class InitialInfoDto implements Serializable {

    private int areaId;
    private long buildingId;
    private String detailJuso;

    private static InitialInfoDto instance = new InitialInfoDto();

    private InitialInfoDto () {}

    public static InitialInfoDto getInstance(int areaId, long buildingId, String detailJuso) {

        instance.setAreaId(areaId);
        instance.setBuildingId(buildingId);
        instance.setDetailJuso(detailJuso);
        return instance;
    }

    public int getAreaId() {
        return areaId;
    }
    public long getBuildingId() {
        return buildingId;
    }
    public String getDetailJuso() {
        return detailJuso;
    }
    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }
    public void setBuildingId(long buildingId) {
        this.buildingId = buildingId;
    }
    public void setDetailJuso(String detailJuso) {
        this.detailJuso = detailJuso;
    }


}