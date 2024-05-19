import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/layout/main_layout.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:provider/provider.dart';
import '../stores/goods_store.dart';
import '../stores/user_secure_store.dart';
import '../stores/worker_store.dart';
import 'box_simulation/box_simulation_gobal_setting.dart';
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
    print ("_DashboardSimulation3dPageState build token :  ${Provider.of<UserStore>(context, listen: false).token}");

    if (gGoods.isNotEmpty)
      gGoods.clear();
    if (boxes.isNotEmpty)
      boxes.clear();
    Provider.of<GoodsStore>(context, listen: false).getGoodsFromApi(
        Provider.of<UserStore>(context, listen: false).token
    );

    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    WorkerStore workerStore = Provider.of<WorkerStore>(context, listen: false);
    workerStore.getWorkerInfoFromApi(userStore.token);

    gtruckHeight= workerStore.gtruckHeight.toDouble();
    gtruckLength = workerStore.gtruckLength.toDouble();
    gtruckWidth = workerStore.gtruckWidth.toDouble();

    // truckSize.y = workerStore.gtruckLength.toDouble();
    // truckSize.z = workerStore.gtruckWidth.toDouble();
    //
    // print ("truckSize: ${truckSize.x}, ${truckSize.y}, ${truckSize.z}");


    return MainLayout(
        topBarTitle: '3D 적재 시뮬레이션',
        isFixed: true,
        child: Container(
            child: BoxSimulation3dSecondPage()
        )
    );
  }
}
