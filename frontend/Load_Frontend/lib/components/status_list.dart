import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:load_frontend/model.dart';
import 'package:load_frontend/components/status_card.dart';
import 'package:load_frontend/models/worker_info_data.dart';
import 'package:load_frontend/services/user_service.dart';
import 'package:load_frontend/stores/worker_store.dart';
import 'package:provider/provider.dart';

import '../constaints.dart';
import '../stores/user_store.dart';

final List<BussinessStatus> statusList = [
  BussinessStatus('Total Sales', '1123456 \$', Icons.show_chart_outlined),
  BussinessStatus('Total Profit', '11234 \$', Icons.attach_money_outlined),
  BussinessStatus('Orders', '1236', Icons.shopping_cart_outlined),
  BussinessStatus('Customers', '11234', Icons.people_outline_outlined),
];

class StatusList extends StatefulWidget {
  StatusList({Key? key}) :super(key: key);

  @override
  _StatusListState createState() => _StatusListState();
}
class _StatusListState extends State<StatusList>{
  String name = '';
  String todayDate = '';

  @override
  void initState() {
    WorkerStore ws = Provider.of<WorkerStore>(context,listen: false);
    UserStore us = Provider.of<UserStore>(context, listen:false);

    ws.getWorkerInfoFromApi(us.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    var workerinfo = Provider.of<WorkerStore>(context,listen: false).workerInfo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " ${Provider.of<WorkerStore>(context, listen: true).workerInfo.name} 기사님 2024-05-05 배송관리",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: componentPadding,
        ),
        StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: componentPadding,
            crossAxisSpacing: componentPadding,
            itemCount: statusList.length,
            itemBuilder: (context, index) => StatusCard(index), //index 별로 컴포넌트 구분
            staggeredTileBuilder: (index) {
              if (_size.width > screenXxl) return StaggeredTile.fit(1);
              if (_size.width > screenSm) return StaggeredTile.fit(2);
              return StaggeredTile.fit(4);
            })
      ],
    );
  }
}


