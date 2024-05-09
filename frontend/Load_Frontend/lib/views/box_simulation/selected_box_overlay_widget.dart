// import 'package:flutter/material.dart';
// import 'package:load_frontend/stores/goods_store.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// import '../../constaints.dart';
// import '../../themes/login_style.dart';
//
// class SelectedBoxOverlayWidget {
//   static late OverlayEntry overlayEntry;
//   Offset position;
//   final Size size;
//   final BuildContext context;
//
//   bool isShowing = false;
//
//   SelectedBoxOverlayWidget({
//     required this.context,
//     this.position = const Offset(100, 100),
//     this.size = const Size(300, 500),
//   }) {
//     overlayEntry = createOverlayEntry();
//   }
//
//   OverlayEntry createOverlayEntry() {
//     return OverlayEntry(
//         builder: (context) => //Scaffold(
//             Theme(
//                 data: loginTheme,
//                 child: Positioned(
//                   left: position.dx,
//                   top: position.dy,
//                   child: GestureDetector(
//                     onPanUpdate: (details) {
//                       position += details.delta;
//                       overlayEntry.markNeedsBuild();
//                     },
//                     child: Container(
//                         width: size.width,
//                         height: size.height,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.8),
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
//                         child: Column(
//                           children: [
//                             Container(
//                                 width: double.infinity,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                   borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       topRight: Radius.circular(10)),
//                                   color: primaryAncient.withOpacity(0.6),
//                                 ),
//                                 child: Center(
//                                   child: DefaultTextStyle(
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       child: Text(
//                                         'Selected Goods : ${Provider.of<GoodsStore>(context)?.selectedGoods?.goodsId ?? "none"} ',
//                                         style: TextStyle(
//                                             color: textColor,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600),
//                                       )),
//                                 )),
//                             Expanded(
//                                 // 내용을 스크롤 가능하게 만듭니다.
//                                 child: SingleChildScrollView(
//                               child: DefaultTextStyle(
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   child: Text(
//                                     'Goods Details:\n'
//                                         'ID: ${Provider.of<GoodsStore>(context).selectedGoods?.goodsId ?? "none"}\n'
//                                         'Type: ${Provider.of<GoodsStore>(context).selectedGoods?.type ?? "Unknown"}\n'
//                                         'Position: ${Provider.of<GoodsStore>(context).selectedGoods?.position.toString() ?? "Unknown"}\n'
//                                         'Weight: ${Provider.of<GoodsStore>(context).selectedGoods?.weight.toString() ?? "Unknown"} kg\n'
//                                         'Building ID: ${Provider.of<GoodsStore>(context).selectedGoods?.buildingId ?? "Unknown"}\n'
//                                         'Building Name: ${Provider.of<GoodsStore>(context).selectedGoods?.buildingName ?? "Unknown"}\n'
//                                         'Detail Address: ${Provider.of<GoodsStore>(context).selectedGoods?.detailAddress ?? "Unknown"}',
//                                     style: TextStyle(
//                                       color: textColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                                   )),
//                             ))
//                           ],
//                         )),
//                   ),
//                 )));
//   }
//
//   void show() {
//     if (isShowing) {
//       remove();
//     }
//     Overlay.of(context)?.insert(overlayEntry);
//     isShowing = true;
//   }
//
//   void remove() {
//     isShowing = false;
//     overlayEntry.remove();
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:load_frontend/stores/goods_store.dart';

import '../../constaints.dart';
import '../../themes/login_style.dart';

class SelectedBoxOverlayWidget {
  static late OverlayEntry overlayEntry;
  Offset position;
  final Size size;
  final BuildContext context;

  bool isShowing = false;

  SelectedBoxOverlayWidget({
    required this.context,
    this.position = const Offset(250, 100),
    this.size = const Size(300, 400),
  }) {
    overlayEntry = createOverlayEntry();
  }

  OverlayEntry createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Theme(
              data: loginTheme,
              child: Positioned(
                left: position.dx,
                top: position.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    position += details.delta;
                    overlayEntry.markNeedsBuild();
                  },
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
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
                        Stack(
                          children: [
                            Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: primaryAncient.withOpacity(0.6),
                                ),
                                child: Center(
                                  child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      child: Text(
                                        'Selected Goods',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                )),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: IconButton(
                                icon: Icon(Icons.close, color: Colors.black),
                                onPressed: () {
                                  remove(); // Close the overlay
                                },
                              ),
                            )
                          ],
                        ),
                        Divider(height: 2),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextDetailRow(
                                    title: "Goods ID:",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.goodsId ?? "none"}"),
                                TextDetailRow(
                                    title: "Type:",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.type ?? "Unknown"}"),
                                TextDetailRow(
                                    title: "Position:",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.position.toString() ?? "Unknown"}"),
                                TextDetailRow(
                                    title: "Weight:",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.weight.toString() ?? "Unknown"} g"),
                                TextDetailRow(
                                    title: "Building ID(region):",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.buildingId ?? "Unknown"}"),
                                TextDetailRow(
                                    title: "Building Name:",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.buildingName ?? "Unknown"}"),
                                TextDetailRow(
                                    title: "Detail Address:",
                                    value:
                                        "${Provider.of<GoodsStore>(context).selectedGoods?.detailAddress ?? "Unknown"}"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  void show() {
    if (isShowing) {
      remove();
    }
    Overlay.of(context)?.insert(overlayEntry);
    isShowing = true;
  }

  void remove() {
    isShowing = false;
    overlayEntry.remove();
  }
}

class TextDetailRow extends StatelessWidget {
  final String title;
  final String value;

  const TextDetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              child: Text(
                "$title ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
