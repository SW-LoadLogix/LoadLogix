import 'dart:convert';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:http/http.dart' as http;
import 'package:load_frontend/views/box_simulation/box.dart';

import '../models/vector3.dart';
import '../views/box_simulation/box_simulation_gobal_setting.dart';
import 'base_url.dart';

bool isDebug = false;

class GoodsService {
  final baseUrl = dotenv.get("BASE_URL");
  Future<List<GoodsData>> getGoods(String accessToken) async {
    if (isDebug) {
      List<GoodsData> goods = [];
      Random random = Random();


      //three.Vector3 truckSize = three.Vector3(280 * gScale , 160 * gScale, 160 * gScale);

      int goodsId = 0;


      List<dynamic> array =[{'position': {'x': 0.0, 'y': 0.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 0.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 0.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 0.0, 'z': 0.0}, 'size': {'x': 41.0, 'y': 41.0, 'z': 28.0}}, {'position': {'x': 48.0, 'y': 0.0, 'z': 28.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 0.0, 'z': 62.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 0.0, 'z': 28.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 0.0, 'z': 62.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 48.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 48.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 48.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 48.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 48.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 48.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 48.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 48.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 48.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 96.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 96.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 0.0, 'y': 96.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 96.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 96.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 48.0, 'y': 96.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 96.0, 'z': 0.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 96.0, 'z': 34.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}, {'position': {'x': 96.0, 'y': 96.0, 'z': 68.0}, 'size': {'x': 48.0, 'y': 48.0, 'z': 34.0}}]
;



      /*


       if (type == 'L1') {
      boxSize = three.Vector3(22 * gScale,9 * gScale, 22 * gScale);
    } else if (type == 'L2') {
      boxSize = three.Vector3(27 * gScale,15 * gScale, 27 * gScale);
    } else if (type == 'L3') {
      boxSize = three.Vector3(35 * gScale,10 * gScale, 35 * gScale);
    } else if (type == 'L4') {
      boxSize = three.Vector3(34 * gScale, 21 * gScale, 34 * gScale);
    } else if (type == 'L5') {
      boxSize = three.Vector3(41 * gScale,28 * gScale, 41 * gScale);
    } else if (type == 'L6') {
      boxSize = three.Vector3(48 * gScale,34 * gScale, 48 * gScale);
    }
       */


      print ("arraysize: ${array.length}");
      print("array : $array");
      for (int i = 0 ; i < array.length; i++) {
        var obj = array[i];
        print(obj);
        String type = "L1";
        if (obj['size']?['x'] == 48) {
          type = 'L6';
        } else if (obj['size']?['x'] == 41) {
          type = 'L5';
        } else if (obj['size']?['x'] == 35) {
          type = 'L4';
        } else if (obj['size']?['x'] == 34) {
          type = 'L3';
        } else if (obj['size']?['x'] == 27) {
          type = 'L2';
        } else if (obj['size']?['x'] == 22) {
          type = 'L1';
        }

        goods.add(
            GoodsData(
            goodsId: goodsId++,
            type: type,
            position: Vector3(
                (obj['position']?['x'] as double) * gScale,
                (obj['position']?['z'] as double) * gScale,
                (obj['position']?['y'] as double) * gScale),
            weight: random.nextInt(1000),
            buildingId: random.nextInt(10),
            buildingName: 'Building Name ${random.nextInt(10)}',
            detailAddress: '서울시 강남구 삼성동 123-456')
        );
      }

      // for (int x = 0; x < 6; x++) {
      //   for (int y = 0; y < 6; y++) {
      //     for (int z = 0; z < 6; z++) {
      //       String type = 'L${random.nextInt(6) + 1}';  // Random type between S1 and S6
      //
      //       int buildingId = random.nextInt(10);
      //
      //       goods.add(GoodsData(
      //           goodsId: goodsId++,
      //           type: type,
      //           position: Vector3(
      //               x.toDouble() * gtruckWidth / 6.0 * gScale,
      //               z.toDouble() * gtruckHeight / 6.0* gScale,
      //               y.toDouble() * gtruckLength / 6.0* gScale
      //           ),
      //           //position: Vector3(x.toDouble(), y as double, z as double),
      //           size: Vector3(size.x, size.z, size.y),
      //           weight: random.nextInt(1000),
      //           buildingId: buildingId,
      //           buildingName: 'Building Name ${buildingId}',
      //           detailAddress: '서울시 강남구 삼성동 123-456'));
      //       // if (goods.length == 10)
      //       //   return goods;
      //     }
      //   }
      // }
      print("goods : $goods");
      return goods;
    }

    final response = await http.get(Uri.parse('${baseUrl}/api/goods/loads'), headers: {"Authorization":  "Bearer $accessToken"});
    if (response.statusCode == 200) {
      List<GoodsData> goods = [];
      var data = json.decode(response.body);
      print("data: $data");
      Random random = Random();
      for (var i in data['result']['goods']) {
        GoodsData goodsData = GoodsData.fromJson(i);
        goods.add(GoodsData(
            goodsId: goodsData.goodsId,
            type: goodsData.type,
            position: Vector3(
                goodsData.position.x.toDouble() * gScale,//* 280 / 6.0 * gScale,
                goodsData.position.z.toDouble() * gScale,//* 160 / 6.0 * gScale,
                goodsData.position.y.toDouble() * gScale),//* 160 / 6.0 * gScale),
            //position: Vector3(x.toDouble(), y as double, z as double),

            weight: goodsData.weight,
            buildingId: goodsData.buildingId,
            buildingName: goodsData.buildingName,
            detailAddress: goodsData.detailAddress));
      }
      return goods;
    } else {
      print('Failed to load goods');
      return [];
    }
  }
}
