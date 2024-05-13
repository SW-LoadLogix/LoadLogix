import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/components/charts.dart';
import 'package:load_frontend/components/status_list.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/layout/main_layout.dart';
import 'package:load_frontend/models/delivery_data.dart';
import 'package:load_frontend/services/delivery_service.dart';
import 'package:provider/provider.dart';
import '../stores/delivery_store.dart';
import '../stores/user_store.dart';
import '../components/delivery_table.dart';

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
  void initState() {
    super.initState();
    // Call API to fetch initial data when widget is initialized
  }

  @override
  Widget build(BuildContext context) {

    print ("DashboardPage build token :  ${Provider.of<UserStore>(context, listen: false).token}");
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    DeliveryStore deliveryStore = Provider.of<DeliveryStore>(context, listen: false);
    deliveryStore.getDeliveryServiceFromApi(userStore.token);
    print(deliveryStore.deliveryData.toString());

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
          DeliveryTable(),
        ],
    ));
  }
}
