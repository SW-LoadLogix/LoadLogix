import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/components/week_delivery_total_chart.dart';
import 'package:load_frontend/widgets/pie_chart.dart';

import 'map.dart';

class Charts extends StatelessWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= screenLg) {
      return Row(
        children: [
          Flexible(flex: 1, child: WeekDeliveryTotalChart()),
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
        WeekDeliveryTotalChart(),
        SizedBox(
          height: componentPadding,
        ),
        MyGoogleMap(),
      ],
    );
  }
}
