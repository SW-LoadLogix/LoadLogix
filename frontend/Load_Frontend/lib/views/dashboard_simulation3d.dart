import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/components/charts.dart';
import 'package:load_frontend/components/status_list.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/layout/main_layout.dart';
import '../components/order_table.dart';
import 'box_simulation/box_simultation_3d_refactor.dart';

@RoutePage()
class DashboardSimulation3dPage extends StatefulWidget {
  const DashboardSimulation3dPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashboardSimulation3dPageState();
  }
}

class _DashboardSimulation3dPageState extends State<DashboardSimulation3dPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        topBarTitle: '3D Simulation Dashboard',
        isFixed: true,
        child: Container(
            height: 800,
            child: BoxSimulation3dSecondPage()
        )
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     BoxSimulation3dSecondPage(),
        //     /* 대시보드 가운데에 들어감 */
        //     // StatusList(),
        //     // Charts(),
        //     // SizedBox(
        //     //   height: componentPadding,
        //     // ),
        //     // OrderTable(),
        //   ],
        // )
        );
  }
}
