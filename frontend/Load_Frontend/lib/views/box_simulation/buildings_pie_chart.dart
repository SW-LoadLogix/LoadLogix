import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:load_frontend/stores/goods_store.dart';
import 'package:load_frontend/models/good_data.dart';

import 'box_colors.dart';

class BuildingsPieChart extends StatelessWidget {
  const BuildingsPieChart({Key? key}) : super(key: key);

  List<PieChartSectionData> getChartSections(
      BuildContext context, double radius, Map<int, List<GoodsData>> groupedGoods) {
    double total = groupedGoods.values.fold(0, (sum, list) => sum + list.length);
    return groupedGoods.entries.map((entry) {
      final colorIndex = entry.key % distinctColors.length;
      final color = distinctColors[colorIndex];
      final percentage = (entry.value.length / total) * 100;
      return PieChartSectionData(
          color: color,
          value: entry.value.length.toDouble(),
          title: '${entry.value.length}',
          radius: radius * 0.4,
          titleStyle: TextStyle(
              fontSize: 20,//radius / 3.5,
              fontWeight: FontWeight.w600,
              shadows: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset(2, 2))
              ],
              color: Colors.white),
          showTitle: true);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double chartRadius = constraints.maxWidth/1.2 ;/// 6; // 제공된 너비를 기준으로 크기 결정
        final goodsStore = Provider.of<GoodsStore>(context);
        final Map<int, List<GoodsData>> groupedGoods = goodsStore.goodsGroupedByBuildingId;

        return Container(
          child: PieChart(
            PieChartData(
                sections: getChartSections(context, chartRadius, groupedGoods),
                centerSpaceRadius: 0,
                //centerSpaceRadius: chartRadius / 0.6, // 중앙 공간 설정
                sectionsSpace: 4, // 섹션 사이 간격
                startDegreeOffset: 0),
            swapAnimationDuration: Duration(milliseconds: 1000),
          ),
        );
      },
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:load_frontend/constaints.dart';
// import 'package:provider/provider.dart';
// import 'package:load_frontend/stores/goods_store.dart';
//
// import '../../models/good_data.dart';
// import 'box_colors.dart';
//
// class BuildingsPieChart extends StatelessWidget {
//   const BuildingsPieChart({Key? key}) : super(key: key);
//
//   List<PieChartSectionData> getChartSections(
//       BuildContext context, double radius, Map<int, List<GoodsData>> groupedGoods) {
//     double total = groupedGoods.values.fold(0, (sum, list) => sum + list.length);
//     return groupedGoods.entries.map((entry) {
//       final colorIndex = entry.key % distinctColors.length; // 색상 배열 인덱스
//       final color = distinctColors[colorIndex];
//       final percentage = (entry.value.length / total) * 100;
//       return PieChartSectionData(
//           color: color,
//           value: entry.value.length.toDouble(),
//           title: '${percentage.toStringAsFixed(1)}%',
//           radius: radius,
//           titleStyle: TextStyle(
//               fontSize: radius / 3,
//               fontWeight: FontWeight.bold,
//               color: Colors.white),
//           showTitle: true);
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final goodsStore = Provider.of<GoodsStore>(context);
//     final Map<int, List<GoodsData>> groupedGoods = goodsStore.goodsGroupedByBuildingId;
//
//     final Size _size = MediaQuery.of(context).size;
//     double chartRadius = _size.width >= screenMd ? 40 : 20;
//
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: primary),
//             borderRadius: BorderRadius.circular(18)),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: PieChart(
//             PieChartData(
//                 sections: getChartSections(context, chartRadius, groupedGoods),
//                 startDegreeOffset: 270),
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:load_frontend/constaints.dart';
//
// class BuildingsPieChart extends StatelessWidget {
//   const BuildingsPieChart({Key? key}) : super(key: key);
//
//   List<PieChartSectionData> getChartSections(
//       BuildContext context, double radius) {
//     return ([
//       PieChartSectionData(
//           color: Theme.of(context).primaryColor,
//           value: 80,
//           radius: radius,
//           showTitle: false),
//       PieChartSectionData(
//         color: Color(0xffCCECDF),
//         value: 20,
//         radius: radius,
//         showTitle: false,
//       ),
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: primary),
//             borderRadius: BorderRadius.circular(18)),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Stack(
//             children: [
//               PieChart(
//                 PieChartData(
//                     sections: getChartSections(
//                         context, _size.width >= screenMd ? 40 : 20),
//                     startDegreeOffset: 270),
//               ),
//               Center(
//                 child: Text(
//                   '60%',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                                 width: 22,
//                                 height: 22,
//                                 decoration: BoxDecoration(
//                                     color: Color(0xffCCECDF),
//                                     borderRadius: BorderRadius.circular(50))),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               '100',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           'Total',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                                 width: 22,
//                                 height: 22,
//                                 decoration: BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                     borderRadius: BorderRadius.circular(50))),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               '60',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           'Total',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
