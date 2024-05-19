/**
 * BuildingDto
 */
public class BuildingDto {

    private int id;
    private int buildingMain;
    private int buildingSub;

    public BuildingDto () {}

    public int getId() {
        return this.id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getBuildingMain() {
        return this.buildingMain;
    }
    public void setBuildingMain(int buildingMain) {
        this.buildingMain = buildingMain;
    }
    public int getBuildingSub() {
        return this.buildingSub;
    }
    public void setBuildingSub(int buildingSub) {
        this.buildingSub = buildingSub;
    }

    @Override
    public String toString() {
        return "BuildingDto [id=" + id + ", buildingMain=" + buildingMain + ", buildingSub=" + buildingSub + "]";
    }

}