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
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
