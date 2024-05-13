import 'dart:math';

import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/model.dart';
import 'package:provider/provider.dart';

import '../models/delivery_data.dart';
import '../stores/delivery_store.dart';

const List<String> imgurl =[
  'assets/images/nav1.png',
  'assets/images/nav2.png',
  'assets/images/nav3.png',
  'assets/images/nav4.png',
];

class BuildingItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    DeliveryData dt = Provider.of<DeliveryStore>(context,listen: true).deliveryData;
    var random = Random();

    return Column(
      children: dt.buildings.map((building){
        int randomNumber = random.nextInt(imgurl.length);
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
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: primary,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(imgurl[randomNumber]))),
              ),
              SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      building.buildingAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${building.totalPercentage.toString()}%",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "택배개수: ${building.totalGoods.toString()}개",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ]
          ),
          );
      }).toList(),
    );
  }
}
