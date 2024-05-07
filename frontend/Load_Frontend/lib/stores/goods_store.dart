


import 'package:flutter/cupertino.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:load_frontend/services/goods_functions.dart';

import '../views/box_simulation/box.dart';

List<GoodsData> gGoods = [];
List<Box> boxes = [];

class GoodsStore extends ChangeNotifier {
  GoodsService goodsService = GoodsService();

  List<GoodsData> goods = [];
  Map<int, List<GoodsData>> goodsGroupedByBuildingId = {};
  Map<int, bool> buildingChecked = {};
  Map<int, Map<int, bool>> goodsChecked = {};

  Future<void> getGoodsFromApi() async {
    goods = await goodsService.getGoods();
    goodsGroupedByBuildingId = await getGoodsGroupedByBuildingId();
    initializeGoodsChecked(goods);

    for(var id in goodsGroupedByBuildingId.keys){
      updateBuildingCheckedState(id);
    }
    gGoods = goods;
    notifyListeners();
  }

  Future<Map<int, List<GoodsData>>> getGoodsGroupedByBuildingId() async {
    Map<int, List<GoodsData>> groupedMap = {};
    for (GoodsData good in goods) {
      if (!groupedMap.containsKey(good.buildingId)) {
        groupedMap[good.buildingId] = [];
      }
      groupedMap[good.buildingId]!.add(good);
    }
    goodsGroupedByBuildingId = groupedMap;
    return groupedMap;
  }

  void initializeGoodsChecked(List<GoodsData> goods) {
    for (var good in goods) {
      if (!goodsChecked.containsKey(good.buildingId)) {
        goodsChecked[good.buildingId] = {};
      }
      goodsChecked[good.buildingId]![good.goodsId] = true;
    }
  }

  void toggleBuilding(int buildingId) {
    final newState = !(buildingChecked[buildingId] ?? false);
    buildingChecked[buildingId] = newState;

    // 모든 상품을 같은 상태로 설정
    final goods = goodsChecked[buildingId];
    if (goods != null) {
      for (var goodsId in goods.keys) {
        goods[goodsId] = newState;
      }
    }
    for (var box in boxes){
      if (box.buildingId == buildingId){
        box.isChecked = newState;
      }
    }
    notifyListeners();
  }

  void toggleGood(int buildingId, int goodsId) {
    final goods = goodsChecked[buildingId];
    if (goods != null) {
      goods[goodsId] = !(goods[goodsId] ?? false);
    }
    for (var box in boxes){
      if (box.goodsId == goodsId){
        box.isChecked = goods![goodsId]!;
        break;
      }
    }
    notifyListeners();
  }

  void updateBuildingCheckedState(int buildingId) {
    final goods = goodsChecked[buildingId];
    if (goods != null && goods.isNotEmpty) {
      buildingChecked[buildingId] = goods.values.every((checked) => checked);
    }
  }

  bool isBuildingChecked(int buildingId) {
    return buildingChecked[buildingId] ?? false;
  }

  bool isGoodChecked(int buildingId, int goodsId) {
    return goodsChecked[buildingId]?[goodsId] ?? false;
  }

}
