import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:load_frontend/stores/goods_store.dart';
import 'package:load_frontend/views/box_simulation/goods_expansion_panel.dart';
import 'package:load_frontend/views/box_simulation/sim_sidebar_content.dart';
import 'package:load_frontend/views/box_simulation/simulation_controller.dart';
import 'package:load_frontend/views/goodsdummy.dart';
import 'package:provider/provider.dart';

import '../../constaints.dart';
import 'buildings_pie_chart.dart';

class SimSidebarPage extends StatelessWidget {
  final bool showDesktop;

  const SimSidebarPage([this.showDesktop = false]);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;
    final goodsStore = context.watch<GoodsStore>();
    Map<int, List<GoodsData>> groupedGoods =
        context.watch<GoodsStore>().goodsGroupedByBuildingId;
    // print("key length:  ${groupedGoods.keys.length}");

    return Container(
      width: _isDesktop ? rightsideBarDesktopWidth : sideBarMobileWidth + 18,
      color: primaryLight.withAlpha(100),
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: topBarHeight,
            child: Row(
              children: [
                _isDesktop
                    ? Expanded(
                    child: Center(
                      child: Text(
                        'Simulation Control',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ))
                    : IconButton(
                  icon: Icon(
                    Icons.menu_open,
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: AspectRatio(
                          aspectRatio: 1.3,
                          child: BuildingsPieChart(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: primaryAncient.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Goods: ${goodsStore.goods.length}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                Expanded(
                                  // 내용을 스크롤 가능하게 만듭니다.
                                    child: SingleChildScrollView(
                                      child: GoodsExpansionPanel(),
                                    ))
                              ],
                            )
                        )
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: primaryAncient.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Control',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                Expanded(
                                  // 내용을 스크롤 가능하게 만듭니다.
                                    child: SingleChildScrollView(
                                      child: SimulationController(),
                                    ))
                              ],
                            )
                        )
                    ),
                    // Flexible(
                    //     flex: 2,
                    //     fit: FlexFit.tight,
                    //     child: Container(
                    //         width: double.infinity,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(10),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.2),
                    //               spreadRadius: 1,
                    //               blurRadius: 6,
                    //               offset: Offset(0, 3),
                    //             ),
                    //           ],
                    //         ),
                    //         child: SingleChildScrollView(
                    //           child: Column(
                    //             children: [
                    //               SimulationController(),
                    //             ],
                    //           ),
                    //         ))),
                    SizedBox(
                      height: 12,
                    ),
                  ]))
        ],
      ),
    );
  }
}
