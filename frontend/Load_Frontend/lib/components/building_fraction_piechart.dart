import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/delivery_data.dart';
import '../stores/delivery_store.dart';
import 'constants.dart';



List<Color> generateDistinctColors(int count) {
  List<Color> colors = [];
  for (int i = 0; i < 20; i++) {
    // Colors 클래스에 정의된 색상 중 랜덤하게 선택하여 리스트에 추가
    Color color = Colors.primaries[i % Colors.primaries.length].withOpacity(0.5);
    colors.add(color);
  }
  return colors;
}

List<Color> distinctColor = generateDistinctColors(20);




List<PieChartSectionData> paiChartSelectionData = [
  // PieChartSectionData(
  //   color: primaryColor,
  //   value: 25,
  //   showTitle: false,
  //   radius: 25,
  // ),
  // PieChartSectionData(
  //   color: Color(0xFF26E5FF),
  //   value: 20,
  //   showTitle: false,
  //   radius: 22,
  // ),
  // PieChartSectionData(
  //   color: Color(0xFFFFCF26),
  //   value: 10,
  //   showTitle: false,
  //   radius: 19,
  // ),
  // PieChartSectionData(
  //   color: Color(0xFFEE2727),
  //   value: 15,
  //   showTitle: false,
  //   radius: 16,
  // ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 13,
  // ),
];


class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DeliveryData dt = Provider.of<DeliveryStore>(context,listen: true).deliveryData;
    paiChartSelectionData.clear();

    double maxPercent = 0.0;
    for (int i = 0; i < dt.buildings.length;i++) {
      var currBuilding = dt.buildings[i];
      if (currBuilding.totalPercentage > maxPercent){
        maxPercent = currBuilding.totalPercentage as double;
      }
    }

    for (int i = 0; i < dt.buildings.length;i++){
      var currBuilding = dt.buildings[i];
      paiChartSelectionData.add(
          PieChartSectionData(
            color:distinctColor[i%distinctColor.length],
            value: currBuilding.totalGoods as double,
            showTitle: true,
            radius: 65 * currBuilding.totalPercentage / maxPercent,
          )
      );
    }

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 30,
              startDegreeOffset: -90,
              sections: paiChartSelectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: defaultPadding),
                Text(
                  "${dt.total.toString()} 건",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        height: 0.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
