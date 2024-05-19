import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/models/good_data.dart';
import 'package:load_frontend/stores/goods_store.dart';
import 'package:load_frontend/views/box_simulation/goods_expansion_panel.dart';
import 'package:load_frontend/views/box_simulation/pie_test.dart';
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
    Map<int, List<GoodsData>> groupedGoods = goodsStore.goodsGroupedByBuildingId;
    final _isMobile = _size.width < screenSm;

    double rightsideBarDesktopWidth = rightSideBarDesktopWidth;
    if (_isMobile) {
      rightsideBarDesktopWidth = 0;
    } else {
      if (_isDesktop) {
        rightsideBarDesktopWidth = rightSideBarDesktopWidth;
      } else {
        rightsideBarDesktopWidth = rightSideBarDesktopWidth;
      }
    }

    return Container(
      width: rightsideBarDesktopWidth,
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
                        child: SafeArea(
                          child: Text(
                            '시뮬레이션 컨트롤 센터',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        )))
                    : Expanded(
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.menu_open,
                          size: 20,
                        ),
                        onPressed: () {
                          //Navigator.pop(context);
                        },
                      ),
                    ))
              ],
            ),
          ),
          !_isMobile
              ? Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 250,
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
                      child: Column(children: [
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
                                '총 구역 개수 : ${groupedGoods.keys.length}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Expanded(
                          child: PieTooltipPosition(Key('pie')),
                        ),
                      ]),
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
                                        '총 배송 물품 개수: ${goodsStore.goods.length}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                Expanded(
                                    child: SingleChildScrollView(
                                      child: GoodsExpansionPanel(),
                                    ))
                              ],
                            ))),
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
                                        '제어 센터',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                Expanded(
                                    child: SingleChildScrollView(
                                      child: SimulationController(),
                                    ))
                              ],
                            ))),
                    SizedBox(
                      height: 12,
                    ),
                  ]))
              : Expanded(
            child: Container(
              width: 0,
            ),
          )
        ],
      ),
    );
  }
}


// class SimSidebarPage extends StatelessWidget {
//   final bool showDesktop;
//
//   const SimSidebarPage([this.showDesktop = false]);
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     final bool _isDesktop = _size.width >= screenLg;
//     final goodsStore = context.watch<GoodsStore>();
//     Map<int, List<GoodsData>> groupedGoods =
//         context.watch<GoodsStore>().goodsGroupedByBuildingId;
//     // print("key length:  ${groupedGoods.keys.length}");
//     final _isMobile = _size.width < screenSm;
//
//     double rightsideBarDesktopWidth = rightSideBarDesktopWidth;
//     if (_isMobile) {
//       rightsideBarDesktopWidth = 0;
//     } else {
//       if (_isDesktop) {
//         rightsideBarDesktopWidth = rightSideBarDesktopWidth;
//       } else {
//         rightsideBarDesktopWidth = rightSideBarDesktopWidth;
//       }
//     }
//
//     return Container(
//       width: rightsideBarDesktopWidth,
//       color: primaryLight.withAlpha(100),
//       padding: EdgeInsets.symmetric(horizontal: componentPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             height: topBarHeight,
//             child: Row(
//               children: [
//                 _isDesktop
//                     ? Expanded(
//                         child: Center(
//                             child: SafeArea(
//                         child: Text(
//                           '시뮬레이션 컨트롤 센터',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                       )))
//                     : Expanded(
//                         child: Center(
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.menu_open,
//                             size: 20,
//                           ),
//                           onPressed: () {
//                             //Navigator.pop(context);
//                           },
//                         ),
//                       ))
//               ],
//             ),
//           ),
//           !_isMobile
//               ? Expanded(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                       Container(
//                         height: 250,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 1,
//                               blurRadius: 6,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(children: [
//                           Container(
//                               width: double.infinity,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10)),
//                                 color: primaryAncient.withOpacity(0.6),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '총 구역 개수 : ${groupedGoods.keys.length}',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               )),
//                           Expanded(
//                             child: PieTooltipPosition(Key('pie')),
//                           ),
//                         ]),
//                       ),
//
//
//
//                       // Container(
//                       //   width: double.infinity,
//                       //   height: 300,
//                       //   child: PieTooltipPosition(Key('pie')),
//                       // ),
//                       //PieTest(),
//                       // Container(
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white,
//                       //     borderRadius: BorderRadius.circular(10),
//                       //     boxShadow: [
//                       //       BoxShadow(
//                       //         color: Colors.grey.withOpacity(0.2),
//                       //         spreadRadius: 1,
//                       //         blurRadius: 6,
//                       //         offset: Offset(0, 3),
//                       //       ),
//                       //     ],
//                       //   ),
//                       //   child: AspectRatio(
//                       //     aspectRatio: 1.3,
//                       //     child: BuildingsPieChart(),
//                       //   ),
//                       // ),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       Flexible(
//                           flex: 2,
//                           fit: FlexFit.tight,
//                           child: Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.2),
//                                     spreadRadius: 1,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                       width: double.infinity,
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(10),
//                                             topRight: Radius.circular(10)),
//                                         color: primaryAncient.withOpacity(0.6),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           '총 배송 물품 개수: ${goodsStore.goods.length}',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       )),
//                                   Expanded(
//                                       child: SingleChildScrollView(
//                                     child: GoodsExpansionPanel(),
//                                   ))
//                                 ],
//                               ))),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       Flexible(
//                           flex: 2,
//                           fit: FlexFit.tight,
//                           child: Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.2),
//                                     spreadRadius: 1,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                       width: double.infinity,
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(10),
//                                             topRight: Radius.circular(10)),
//                                         color: primaryAncient.withOpacity(0.6),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           '제어 센터',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       )),
//                                   Expanded(
//                                       child: SingleChildScrollView(
//                                     child: SimulationController(),
//                                   ))
//                                 ],
//                               ))),
//                       SizedBox(
//                         height: 12,
//                       ),
//                     ]))
//               : Expanded(
//                   child: Container(
//                     width: 0,
//                   ),
//                 )
//         ],
//       ),
//     );
//   }
// }
