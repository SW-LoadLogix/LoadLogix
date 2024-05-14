//
//
//
// import 'dart:js';
//
// import 'package:flutter/cupertino.dart';
// import 'package:load_frontend/models/good_data.dart';
// import 'package:load_frontend/models/vector3.dart';
// import 'package:load_frontend/services/goods_service.dart';
// import 'package:load_frontend/stores/user_secure_store.dart';
// import 'package:load_frontend/stores/user_store.dart';
// import 'package:provider/provider.dart';
//
// import '../views/box_simulation/box.dart';
//
// List<GoodsData> gGoods = [];
// List<SimulBox> boxes = [];
//
// class GoodsStore extends ChangeNotifier {
//   GoodsService goodsService = GoodsService();
//
//   List<GoodsData> goods = [];
//   Map<int, List<GoodsData>> goodsGroupedByBuildingId = {};
//   Map<int, bool> buildingChecked = {};
//   Map<int, Map<int, bool>> goodsChecked = {};
//   int selectedGoodsId = 0;
//   Map<int, int> numberMapping = {};
//
//
//   Map<int, List<GoodsData>>  getgoodsGroupedByBuildingId(){
//     notifyListeners();
//     return goodsGroupedByBuildingId;
//   }
//
//   GoodsData selectedGoods = GoodsData(
//     goodsId: 0,
//     buildingId: 0,
//     buildingName: '',
//     type: '',
//     weight: 0,
//     position: Vector3(0, 0, 0),
//     detailAddress: 'none',
//   );
//
//   void setSelectedGoodsId(int goodsId) {
//     selectedGoodsId = goodsId;
//     selectedGoods = goods.firstWhere((element) => element.goodsId == goodsId);
//     notifyListeners();
//   }
//
//   Map<int, int> mapNumbersToSequential(List<int> numbers) {
//     Map<int, int> mapping = {};
//     int counter = 0;
//
//     for (int number in numbers) {
//       if (!mapping.containsKey(number)) {
//         // 중복된 숫자를 다시 매핑하지 않도록 확인
//         mapping[number] = counter++;
//       }
//     }
//
//     return mapping; // 매핑 결과 반환
//   }
//
//   Future<void> getGoodsFromApi(String accessToken) async {
//     //String? token = await Provider.of<UserSecureStorage>(context as BuildContext, listen: false).getToken();
//     //print ("token: $token");
//
//
//     print ("token on Goods Api: $accessToken");
//
//
//     //String? token = await UserSecureStorage().getToken();
//
//     goods = await goodsService.getGoods(accessToken);
//     goodsGroupedByBuildingId = await getGoodsGroupedByBuildingId();
//     initializeGoodsChecked(goods);
//
//     for(var id in goodsGroupedByBuildingId.keys){
//       updateBuildingCheckedState(id);
//     }
//     gGoods = goods;
//
//     List<int> numbers = [];
//     for (int i = 0; i < gGoods.length; i++) {
//       numbers.add(gGoods[i].buildingId);
//     }
//     numberMapping = mapNumbersToSequential(numbers);
//
//
//     notifyListeners();
//   }
//
//   Future<Map<int, List<GoodsData>>> getGoodsGroupedByBuildingId() async {
//     Map<int, List<GoodsData>> groupedMap = {};
//     for (GoodsData good in goods) {
//       if (!groupedMap.containsKey(good.buildingId)) {
//         groupedMap[good.buildingId] = [];
//       }
//       groupedMap[good.buildingId]!.add(good);
//     }
//     goodsGroupedByBuildingId = groupedMap;
//     return groupedMap;
//   }
//
//   void initializeGoodsChecked(List<GoodsData> goods) {
//     for (var good in goods) {
//       if (!goodsChecked.containsKey(good.buildingId)) {
//         goodsChecked[good.buildingId] = {};
//       }
//       goodsChecked[good.buildingId]![good.goodsId] = true;
//     }
//   }
//
//   void toggleBuilding(int buildingId) {
//     final newState = !(buildingChecked[buildingId] ?? false);
//     buildingChecked[buildingId] = newState;
//
//     // 모든 상품을 같은 상태로 설정
//     final goods = goodsChecked[buildingId];
//     if (goods != null) {
//       for (var goodsId in goods.keys) {
//         goods[goodsId] = newState;
//       }
//     }
//     for (var box in boxes){
//       if (box.buildingId == buildingId){
//         box.isChecked = newState;
//       }
//     }
//     notifyListeners();
//   }
//
//   void toggleGood(int buildingId, int goodsId) {
//     final goods = goodsChecked[buildingId];
//     if (goods != null) {
//       goods[goodsId] = !(goods[goodsId] ?? false);
//     }
//     for (var box in boxes){
//       if (box.goodsId == goodsId){
//         box.isChecked = goods![goodsId]!;
//         break;
//       }
//     }
//     notifyListeners();
//   }
//
//
//
//   void updateBuildingCheckedState(int buildingId) {
//     final goods = goodsChecked[buildingId];
//     if (goods != null && goods.isNotEmpty) {
//       buildingChecked[buildingId] = goods.values.every((checked) => checked);
//     }
//   }
//
//   bool isBuildingChecked(int buildingId) {
//     return buildingChecked[buildingId] ?? false;
//   }
//
//   bool isGoodChecked(int buildingId, int goodsId) {
//     return goodsChecked[buildingId]?[goodsId] ?? false;
//   }
//
// }

import 'package:flutter/cupertino.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:load_frontend/models/vector3.dart';
import 'package:load_frontend/services/goods_service.dart';
import 'package:load_frontend/stores/user_secure_store.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:provider/provider.dart';

import '../views/box_simulation/box.dart';

List<GoodsData> gGoods = [];
List<SimulBox> boxes = [];

class GoodsStore extends ChangeNotifier {
  GoodsService goodsService = GoodsService();

  List<GoodsData> goods = [];
  Map<int, List<GoodsData>> goodsGroupedByBuildingId = {};
  Map<int, bool> buildingChecked = {};
  Map<int, Map<int, bool>> goodsChecked = {};
  int selectedGoodsId = 0;
  Map<int, int> numberMapping = {};

  GoodsData selectedGoods = GoodsData(
    goodsId: 0,
    buildingId: 0,
    buildingName: '',
    type: '',
    weight: 0,
    position: Vector3(0, 0, 0),
    detailAddress: 'none',
  );

  Map<int, List<GoodsData>> get getgoodsGroupedByBuildingId {
    notifyListeners();
    return goodsGroupedByBuildingId;
  }

  void setSelectedGoodsId(int goodsId) {
    selectedGoodsId = goodsId;
    selectedGoods = goods.firstWhere((element) => element.goodsId == goodsId);
    notifyListeners();
  }

  Map<int, int> mapNumbersToSequential(List<int> numbers) {
    Map<int, int> mapping = {};
    int counter = 0;

    for (int number in numbers) {
      if (!mapping.containsKey(number)) {
        mapping[number] = counter++;
      }
    }

    return mapping;
  }

  Future<void> getGoodsFromApi(String accessToken) async {
    goods = await goodsService.getGoods(accessToken);
    goodsGroupedByBuildingId = await getGoodsGroupedByBuildingId();
    initializeGoodsChecked(goods);

    for (var id in goodsGroupedByBuildingId.keys) {
      updateBuildingCheckedState(id);
    }
    gGoods = goods;

    List<int> numbers = [];
    for (int i = 0; i < gGoods.length; i++) {
      numbers.add(gGoods[i].buildingId);
    }
    numberMapping = mapNumbersToSequential(numbers);

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

    final goods = goodsChecked[buildingId];
    if (goods != null) {
      for (var goodsId in goods.keys) {
        goods[goodsId] = newState;
      }
    }
    for (var box in boxes) {
      if (box.buildingId == buildingId) {
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
    for (var box in boxes) {
      if (box.goodsId == goodsId) {
        box.isChecked = goods![goodsId]!;
        break;
      }
    }
    notifyListeners();
  }

  void toggleAll(bool selectAll) {
    if (selectAll) {
      buildingChecked = {
        for (var key in goodsGroupedByBuildingId.keys) key: true
      };
      goodsChecked = {
        for (var entry in goodsGroupedByBuildingId.entries)
          entry.key: {for (var good in entry.value) good.goodsId: true}
      };

      for (var box in boxes) {
          box.isChecked = true;
      }

    } else {
      buildingChecked.clear();
      goodsChecked.clear();
      for (var box in boxes) {
        box.isChecked = false;
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

