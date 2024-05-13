import 'dart:convert';

import 'package:load_frontend/models/building_fraction.dart';

import '../models/delivery_data.dart';
import 'package:http/http.dart' as http;

class DeliveryService {
  Future<DeliveryData?> fetchDeliveryGoods(String accessToken) async {

    try {
      final response = await http.get(Uri.parse('http://43.201.116.59:8081/api/goods/origin'), headers: {
        "Authorization": "Bearer $accessToken"
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return DeliveryData.fromJson(responseBody['result']);
      } else {
        return null;
      }
    } catch (error) {
      throw Exception("Failed to load Delivery List");
    }
  }
}