import 'package:flutter/material.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:load_frontend/stores/goods_store.dart';
import 'package:provider/provider.dart';

class GoodsExpansionPanel extends StatelessWidget {
  const GoodsExpansionPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goodsStore = context.watch<GoodsStore>();
    final Map<int, List<GoodsData>> groupedGoods = goodsStore.goodsGroupedByBuildingId;

    bool allChecked = goodsStore.buildingChecked.length == groupedGoods.length &&
        goodsStore.buildingChecked.values.every((checked) => checked);

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: allChecked,
              onChanged: (bool? checked) {
                goodsStore.toggleAll(checked ?? false);
              },
            ),
            Text(allChecked ? "전체 해제" : "전체 선택"),
          ],
        ),
        ...groupedGoods.entries.map((entry) {
          int buildingId = entry.key;
          List<GoodsData> goods = entry.value;
          return ExpansionTile(
            leading: Checkbox(
              value: goodsStore.isBuildingChecked(buildingId),
              onChanged: (bool? checked) {
                goodsStore.toggleBuilding(buildingId);
              },
            ),
            title: Text('${goods[0].buildingName}'),
            children: goods.map((good) {
              return Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: ListTile(
                  leading: Checkbox(
                    value: goodsStore.isGoodChecked(buildingId, good.goodsId),
                    onChanged: (bool? checked) {
                      goodsStore.toggleGood(buildingId, good.goodsId);
                    },
                  ),
                  title: Text("배송물품 ID ${good.goodsId}"),
                  subtitle: Text('배송상자 타입: ${good.type}, 배송물품 무게: ${good.weight}'),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ],
    );
  }
}
