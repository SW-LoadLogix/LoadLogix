import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/widgets/bar_chart.dart';
import 'package:load_frontend/widgets/pie_chart.dart';

import '../widgets/components/map.dart';

class Charts extends StatelessWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= screenLg) {
      return Row(
        children: [
          Flexible(flex: 1, child: BarChartSample()),
          SizedBox(
            width: componentPadding,
          ),
          Flexible(
            flex: 1,
            child: MyGoogleMap(),
          ),
        ],
      );
    }

    return Column(
      children: [
        BarChartSample(),
        SizedBox(
          height: componentPadding,
        ),
        MyGoogleMap(),
      ],
    );
  }
}
