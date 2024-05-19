// // delivery_table.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import '../models/delivery_data.dart';
// import '../stores/delivery_store.dart';
// import 'dummy.dart';
// // import 'dart:ffi';
//
// class _OrderTableState extends State<DeliveryTable> {
//   late OrderDataSource orderDataSource;
//
//   @override
//   void initState() {
//     super.initState();
//     // 데이터 소스 초기화
//     orderDataSource = OrderDataSource(areaData: dummyData);
//     // 'building_address'를 기준으로 그룹핑을 추가
//     orderDataSource.sortedColumns.add(SortColumnDetails(
//       name: 'building_address',
//       sortDirection: DataGridSortDirection.ascending,
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DeliveryData dt =
//         Provider.of<DeliveryStore>(context, listen: true).deliveryData;
//
//     return Container(
//       height: 400,
//       child: SfTheme(
//         data: SfThemeData(
//           dataGridThemeData: SfDataGridThemeData(
//             headerColor: Color(0xFF89B5A2), // 헤더 배경색을 변경합니다.
//             // Changes the header background color.
//           ),
//         ),
//         child: SfDataGrid(
//           source: orderDataSource,
//           columnWidthMode: ColumnWidthMode.fill,
//           // 열 크기 조절
//           allowSorting: true,
//           // 전체 정렬
//           allowMultiColumnSorting: true,
//           allowExpandCollapseGroup: true,
//           groupCaptionTitleFormat:
//               '{ColumnName} : {Key} - {ItemsCount} Item(s)',
//           columns: <GridColumn>[
//             GridColumn(
//                 columnName: 'goods_id',
//                 label: Container(
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     child: Text(
//                       'ID',
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 width: 60),
//             GridColumn(
//                 columnName: 'address',
//                 label: Container(
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     child: Text(
//                       '배송 상세 주소',
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 width: 300),
//             // GridColumn(
//             //     columnName: 'building_address',
//             //     label: Container(
//             //         padding: EdgeInsets.all(8),
//             //         alignment: Alignment.center,
//             //         child: Text(
//             //           '빌딩주소',
//             //           overflow: TextOverflow.ellipsis,
//             //         )),
//             //     autoFitPadding: EdgeInsets.all(16)),
//             GridColumn(
//                 columnName: 'boxHeight',
//                 label: Container(
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     child: Text(
//                       '높이',
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 autoFitPadding: EdgeInsets.all(16)),
//             GridColumn(
//                 columnName: 'boxLength',
//                 label: Container(
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     child: Text(
//                       '길이',
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 autoFitPadding: EdgeInsets.all(16)),
//             GridColumn(
//                 columnName: 'boxWidth',
//                 label: Container(
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     child: Text(
//                       '폭',
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 autoFitPadding: EdgeInsets.all(16)),
//             GridColumn(
//                 columnName: 'weight',
//                 label: Container(
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     child: Text(
//                       '택배 무게 (g)',
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 width: 100),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // DataGrid 데이터 소스 클래스를 제공하는 클래스
// class OrderDataSource extends DataGridSource {
//   List<DataGridRow> dataGridRows = [];
//   List<String> groupingColumnNames = ['building_address'];
//
//   OrderDataSource({required List<Area> areaData}) {
//     dataGridRows = areaData.expand((area) {
//       return area.buildings.expand((building) {
//         return building.goods.map((good) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: 'goods_id', value: good.goodsId),
//               DataGridCell<String>(columnName: 'address', value: good.address),
//               // DataGridCell<String>(
//               //     columnName: 'building_address', value: building.address),
//               DataGridCell<int>(columnName: 'boxHeight', value: good.boxHeight),
//               DataGridCell<int>(columnName: 'boxLength', value: good.boxLength),
//               DataGridCell<int>(columnName: 'boxWidth', value: good.boxWidth),
//               DataGridCell<int>(columnName: 'weight', value: good.weight),
//             ]));
//       });
//     }).toList();
//   }
//
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//
//   // 각 행을 그리드 행으로 빌드하는 메서드
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         // 행의 배경색을 설정합니다.
//         color: Color(0xffCCECDF), // 모든 행 배경색
//         // color: dataGridRows.indexOf(row) % 2 == 0
//         //     ? Colors.grey[200] // 짝수 행 배경색
//         //     : Colors.white, // 홀수 행 배경색
//         cells: row.getCells().map<Widget>((e) {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8),
//             child: Text(e.value.toString(), overflow: TextOverflow.ellipsis),
//           );
//         }).toList());
//   }
//
//   // 그룹화된 행에 나타날 위젯을 정의
//   @override
//   Widget? buildGroupCaptionCellWidget(
//       RowColumnIndex rowColumnIndex, String summaryValue) {
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//         child: Text(
//           summaryValue,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ));
//   }
// }
//
// // OrderTable 위젯 - 데이터 그리드를 보여주는 위젯
// class DeliveryTable extends StatefulWidget {
//   const DeliveryTable({Key? key}) : super(key: key);
//
//   @override
//   _OrderTableState createState() => _OrderTableState();
// }

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:load_frontend/services/area_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../models/building_data.dart';
import '../models/building_fraction.dart';
import '../models/delivery_data.dart';
import '../stores/delivery_store.dart';
import '../stores/user_store.dart';

class _OrderTableState extends State<DeliveryTable> {
  late OrderDataSource orderDataSource;

  @override
  void initState() {
    super.initState();
    // 데이터 소스 초기화는 이제 build 메서드에서 수행합니다.
  }

  @override
  Widget build(BuildContext context) {
    DeliveryData dt =
        Provider.of<DeliveryStore>(context, listen: true).deliveryData;

    List<BuildingData> buildingDatas =
        Provider.of<DeliveryStore>(context, listen: false).buildingPriority;
    // dt를 기반으로 orderDataSource 초기화
    orderDataSource =
        OrderDataSource(buildings: dt.buildings, buildingDatas: buildingDatas);

    return Container(
      height: 400,
      child: SfTheme(
        data: SfThemeData(
          dataGridThemeData: SfDataGridThemeData(
            headerColor: Color(0xFF89B5A2), // 헤더 배경색을 변경합니다.
          ),
        ),
        child: SfDataGrid(
          source: orderDataSource,
          columnWidthMode: ColumnWidthMode.fill,
          allowSorting: true,
          allowMultiColumnSorting: true,
          allowExpandCollapseGroup: true,
          groupCaptionTitleFormat:
              '{ColumnName} : {Key} - {ItemsCount} Item(s)',
          columns: <GridColumn>[
            GridColumn(
                columnName: 'goods_id',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송 순서',
                      overflow: TextOverflow.ellipsis,
                    )),
                width: 60),
            GridColumn(
                columnName: 'detail_address',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송 상세 주소',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    )),
                width: 350),
            GridColumn(
                columnName: 'box_type',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송상자 타입',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                width: 160),
            GridColumn(
                columnName: 'boxHeight',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송상자 높이(cm)',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                width: 160,
                autoFitPadding: EdgeInsets.all(16)),
            GridColumn(
                columnName: 'boxLength',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송상자 길이(cm)',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                width: 160,
                autoFitPadding: EdgeInsets.all(16)),
            GridColumn(
                columnName: 'boxWidth',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송상자 폭(cm)',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                width: 160,
                autoFitPadding: EdgeInsets.all(16)),
            GridColumn(
                columnName: 'weight',
                label: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      '배송상자 무게(g)',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                autoFitPadding: EdgeInsets.all(16))
            //width: 100),
          ],
        ),
      ),
    );
  }
}

// DataGrid 데이터 소스 클래스를 제공하는 클래스
class OrderDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<String> groupingColumnNames = ['building_address'];

  OrderDataSource(
      {required List<Buildings> buildings,
        required List<BuildingData> buildingDatas}) {
    dataGridRows = buildings
        .expand((building) {

      int? matchingIndex;
      for (int i = 0; i < buildingDatas.length; i++) {
        print("building.buildingAddress  : ${building.buildingAddress} , buildingName: ${buildingDatas[i].buildingName}");
        if (building.buildingAddress.contains(buildingDatas[i].buildingName)) {
          matchingIndex = i;
          break;
        }
      }
      return building.goods.map((good) {
        // buildingDatas에서 buildingName과 good.detailAddress가 일치하는 인덱스를 찾음


        // matchingIndex가 null이면 기본 값 설정
        String formattedIndex = matchingIndex != null
            ? "F${matchingIndex.toString().padLeft(3, '0')}"
            : "F${good.goodsId.toString().padLeft(3, '0')}";

        return DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'goods_id', value: formattedIndex),
          DataGridCell<String>(
              columnName: 'detail_address',
              value: building.topAddress +
                  ' ' +
                  building.buildingAddress +
                  ' ' +
                  good.detailAddress),
          DataGridCell<String>(columnName: 'boxType', value: good.boxType),
          DataGridCell<int>(columnName: 'boxHeight', value: good.boxHeight),
          DataGridCell<int>(columnName: 'boxLength', value: good.boxLength),
          DataGridCell<int>(columnName: 'boxWidth', value: good.boxWidth),
          DataGridCell<int>(columnName: 'weight', value: good.weight),
        ]);
      }).toList();
    })
        .toList()
        .cast<DataGridRow>();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  // 각 행을 그리드 행으로 빌드하는 메서드
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Color(0xffCCECDF), // 모든 행 배경색
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Text(e.value.toString(), overflow: TextOverflow.ellipsis),
          );
        }).toList());
  }

  // 그룹화된 행에 나타날 위젯을 정의
  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Text(
          summaryValue,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}

// DeliveryTable 위젯 - 데이터 그리드를 보여주는 위젯
class DeliveryTable extends StatefulWidget {
  const DeliveryTable({Key? key}) : super(key: key);

  @override
  _OrderTableState createState() => _OrderTableState();
}
