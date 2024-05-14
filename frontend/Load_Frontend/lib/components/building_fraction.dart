import 'package:flutter/material.dart';
import 'package:load_frontend/components/building_fraction_piechart.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/model.dart';
import 'package:load_frontend/components/building_fraction_item.dart';
import 'package:load_frontend/models/delivery_data.dart';
import 'package:load_frontend/services/delivery_service.dart';
import 'package:load_frontend/stores/delivery_store.dart';
import 'package:provider/provider.dart';


class BuildingList extends StatelessWidget {
  final bool showDesktop;
  const BuildingList([this.showDesktop = false]);
  @override
  Widget build(BuildContext context) {

    DeliveryData dt = Provider.of<DeliveryStore>(context,listen: true).deliveryData;

    return Container(
      color: primaryLight.withAlpha(100),
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Column(
        children: [
          Container(
            height: topBarHeight,
            child: Row(
              children: [
                this.showDesktop
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                Expanded(
                    child: Center(
                    child: Text(
                    '${dt.areaName} [총 ${dt.total} 건] 배송 현황 관리',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ))
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Chart(),
                  BuildingItem(),
                  // ...buildings.map((e) => BuildingItem(e)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
