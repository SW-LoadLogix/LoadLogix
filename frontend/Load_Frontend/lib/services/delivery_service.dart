import 'dart:convert';
import 'dart:math';

import 'package:load_frontend/models/building_fraction.dart';
import 'package:load_frontend/models/goods_total_data.dart';

import '../models/delivery_data.dart';
import 'package:http/http.dart' as http;

import 'base_url.dart';

class DeliveryService {
  Future<DeliveryData?> fetchDeliveryGoods(String accessToken) async {

    try {
      final response = await http.get(Uri.parse('${baseUrl}/api/goods/origin'), headers: {
        "Authorization": "Bearer $accessToken"
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return DeliveryData.fromJson(responseBody['result']);
      } else {
        return null;
      }
    } catch (error) {
      print("Failed to load Delivery List");
    }
    return null;
  }

  bool isDebug = true;
  Future<GoodsTotalDataWrapper?> fetchGoodsTotal(String accessToken) async {
    if (isDebug){
      List<GoodsTotalData> gtdl = [];
      DateTime today = DateTime.now();
      
      for (int i = 0; i < 7; i++){
        int  rdnb = Random().nextInt(150);
        DateTime pastDate = today.subtract(Duration(days: i));
        gtdl.add(
            GoodsTotalData(
                date: pastDate,
                total: rdnb
            )
        );
      }
      GoodsTotalDataWrapper gtdw = GoodsTotalDataWrapper(
        amount: gtdl
      );
      return gtdw;
    }
    
    try {
      final response = await http.get(Uri.parse('${baseUrl}/api/goods/total'), headers: {
        "Authorization": "Bearer $accessToken"
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return GoodsTotalDataWrapper.fromJson(responseBody);
      } else {
        return null;
      }
    } catch (error) {
      print("Failed to load Delivery List");
    }
    return null;
  }

}