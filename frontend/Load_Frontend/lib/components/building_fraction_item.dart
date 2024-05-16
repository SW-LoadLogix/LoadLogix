import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/model.dart';
import 'package:provider/provider.dart';

import '../models/building_data.dart';
import '../models/delivery_data.dart';
import '../services/area_service.dart';
import '../stores/delivery_store.dart';
import '../stores/user_store.dart';

class BuildingItem extends StatelessWidget {
  final String fov = "120";
  final String heading = "0";
  final String pitch = "0";

  @override
  Widget build(BuildContext context) {
    // DeliveryData dt = Provider.of<DeliveryStore>(context, listen: true).deliveryData;
    AreaService areaService = AreaService();
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return FutureBuilder<List<BuildingData>>(
      future: areaService.getBuildingPriority(userStore.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<BuildingData> buildings = snapshot.data!;
          int totalGoodsSum = buildings.fold(0, (sum, building) => sum + building.totalGoods);
          return Column(
            children: buildings.map((building) {
              final String apiKey = dotenv.get("GOOGLE_MAPS_API_KEY"); // BuildingData 모델에 apiKey 필드를 추가해야 함
              final double percentage = (building.totalGoods / totalGoodsSum) * 100;
              final String url =
                  "https://maps.googleapis.com/maps/api/streetview"
                  "?size=400x300"
                  "&location=${building.longitude},${building.latitude}"
                  "&fov=$fov"
                  "&heading=$heading"
                  "&pitch=$pitch"
                  "&key=$apiKey";

              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 160,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(url),
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            building.buildingName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${percentage.toStringAsFixed(2)}%", // 소수점 2자리까지 표시
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "택배개수: ${building.totalGoods.toString()}개",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}