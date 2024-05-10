import 'dart:convert';
import 'dart:math';

import 'package:load_frontend/models/good_data.dart';
import 'package:http/http.dart' as http;
import 'package:load_frontend/views/box_simulation/box.dart';

import '../models/vector3.dart';
import 'base_url.dart';

bool isDebug = true;

class GoodsService {
  Future<List<GoodsData>> getGoods() async {
    if (isDebug) {
      List<GoodsData> goods = [];
      Random random = Random();


      //three.Vector3 truckSize = three.Vector3(280 * gScale , 160 * gScale, 160 * gScale);

      int goodsId = 0;
      for (int x = 0; x < 6; x++) {
        for (int y = 0; y < 6; y++) {
          for (int z = 0; z < 6; z++) {
            String type = 'L${random.nextInt(6) + 1}';  // Random type between S1 and S6

            goods.add(GoodsData(
                goodsId: goodsId,
                type: type,
                position: Vector3(x.toDouble() * 280 / 6.0 * gScale, y.toDouble()* 160 / 6.0* gScale, z.toDouble()* 160 / 6.0* gScale),
                //position: Vector3(x.toDouble(), y as double, z as double),

                weight: random.nextInt(1000),
                buildingId: random.nextInt(5),
                buildingName: 'Building Name ${goodsId++}',
                detailAddress: '서울시 강남구 삼성동 123-456'));
          }
        }
      }
      print("goods : $goods");
      return goods;
    }


    final response = await http.get(Uri.parse('$baseUrl/goods'));
    if (response.statusCode == 200) {
      List<GoodsData> goods = [];
      var data = json.decode(response.body);
      for (var i in data) {
        goods.add(GoodsData.fromJson(i));
      }
      return goods;
    } else {
      throw Exception('Failed to load goods');
    }
  }
}
