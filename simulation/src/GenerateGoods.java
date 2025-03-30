/**
 * GenerateGoods
 */
import java.util.Random;

public class GenerateGoods   {
    private final Random random = new Random();

    private static GenerateGoods instance = new GenerateGoods();

    private GenerateGoods () {}
    public static GenerateGoods getInstance() {
        return instance;
    }

    public InitialInfoDto  generateGoodsInfo(InputSettingResponse settingInput) {

        // 빌딩, 구역 랜덤 배정
        List<AreaAndBuilding> settingList = settingInput.getAreaAndBuilding();
        int size = settingList.size();

        AreaAndBuilding areaAndBuilding = settingList.get(random.nextInt(size));

        // 세부 주소 랜덤 배정

        int combinedRange[] = {101, 102, 103, 104, 105, 106, 107, 108, 109,
                201, 202, 203, 204, 205, 206, 207, 208, 209};

        int index = random.nextInt(combinedRange.length);
        String ho = combinedRange[index]+"호";


        return InitialInfoDto.getInstance(areaAndBuilding.getAreaId(),areaAndBuilding.getBuildingId(),ho);
    }

}