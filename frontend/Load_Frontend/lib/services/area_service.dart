import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/building_data.dart';
import 'base_url.dart';

class AreaService {
  Future<List<BuildingData>> getBuildingPriority(String accessToken) async {
    final baseUrl = dotenv.get("BASE_URL");
    final response = await http.get(
        Uri.parse('${baseUrl}/api/path'),
        headers: {
          "Authorization": "Bearer $accessToken"
        }
    );

    if (response.statusCode == 200) {
      List<BuildingData> buildings = [];
      var data = json.decode(response.body);

      if (data['result'] == null) return [];

      for (var i in data['result']) {
        BuildingData buildingData = BuildingData.fromJson(i);
        buildings.add(BuildingData(
          buildingId: buildingData.buildingId,
          buildingName: buildingData.buildingName,
          totalGoods: buildingData.totalGoods,
          latitude: buildingData.latitude,//
          longitude: buildingData.longitude,//
        ));
      }
      return buildings;
    } else {
      return [];
    }
  }
}