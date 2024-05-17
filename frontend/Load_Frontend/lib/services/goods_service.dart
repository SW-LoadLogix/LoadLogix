import 'dart:convert';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:http/http.dart' as http;
import 'package:load_frontend/views/box_simulation/box.dart';

import '../models/vector3.dart';
import '../views/box_simulation/box_simulation_gobal_setting.dart';
import 'base_url.dart';

bool isDebug = true;

class GoodsService {
  final baseUrl = dotenv.get("BASE_URL");
  Future<List<GoodsData>> getGoods(String accessToken) async {
    if (isDebug) {
      List<GoodsData> goods = [];
      Random random = Random();


      //three.Vector3 truckSize = three.Vector3(280 * gScale , 160 * gScale, 160 * gScale);

      int goodsId = 0;
      for (int x = 0; x < 6; x++) {
        for (int y = 0; y < 6; y++) {
          for (int z = 0; z < 6; z++) {
            String type = 'L${random.nextInt(6) + 1}';  // Random type between S1 and S6

            int buildingId = random.nextInt(10);

            goods.add(GoodsData(
                goodsId: goodsId++,
                type: type,
                position: Vector3(x.toDouble() * gtruckWidth / 6.0 * gScale, y.toDouble()* gtruckHeight / 6.0* gScale, z.toDouble()* gtruckLength / 6.0* gScale),
                //position: Vector3(x.toDouble(), y as double, z as double),

                weight: random.nextInt(1000),
                buildingId: buildingId,
                buildingName: 'Building Name ${buildingId}',
                detailAddress: '서울시 강남구 삼성동 123-456'));
            // if (goods.length == 10)
            //   return goods;
          }
        }
      }
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
