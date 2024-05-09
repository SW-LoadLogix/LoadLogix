import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/components/charts.dart';
import 'package:load_frontend/components/status_list.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/layout/main_layout.dart';
import '../components/order_table.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        topBarTitle: 'Dashboard',
        isFixed: false,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /* 대시보드 가운데에 들어감 */
        StatusList(),
        Charts(),
        SizedBox(
          height: componentPadding,
        ),
        OrderTable(),
      ],
    ));
  }
}
