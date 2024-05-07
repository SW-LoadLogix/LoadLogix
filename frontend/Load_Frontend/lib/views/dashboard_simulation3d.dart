import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/layout/main_layout.dart';
import 'package:provider/provider.dart';
import '../stores/goods_store.dart';
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

    if (gGoods.isNotEmpty)
      gGoods.clear();
    if (boxes.isNotEmpty)
      boxes.clear();
    Provider.of<GoodsStore>(context, listen: false).getGoodsFromApi();

    return MainLayout(
        topBarTitle: '3D Simulation Dashboard',
        isFixed: true,
        child: Container(
            child: BoxSimulation3dSecondPage()
        )
    );
  }
}
