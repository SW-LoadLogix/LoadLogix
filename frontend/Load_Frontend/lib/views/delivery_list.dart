import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'goodsdummy.dart';

String toDay = DateFormat('yyyy년 MM월 dd일').format(DateTime.now()); // 현재 일자

@RoutePage()
class DeliveryListPage extends StatelessWidget {
  const DeliveryListPage({super.key});

  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      letterSpacing: 1.2,
      wordSpacing: 2.0,
      height: 1.5,
      decorationStyle: TextDecorationStyle.solid,
      fontFamily: 'IBMPlexMono',
      fontFamilyFallback: ['NotoSans', 'Arial'],
    );

    final TextStyle textStyle2 = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 1.2,
      wordSpacing: 2.0,
      height: 1.5,
      decorationStyle: TextDecorationStyle.solid,
      fontFamily: 'IBMPlexMono',
      fontFamilyFallback: ['NotoSans', 'Arial'],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('적재 전 배송리스트',
          style: TextStyle(
            color: Colors.white,
          ),
        ), // 앱바 타이틀
        backgroundColor: Color(0xFF90D7FF),
      ),
      body: Row(children: [
        //MyNav(),
        Expanded(
          child:
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 60),
                    child: Text('Aishahansten 님의 $toDay Loading List입니다.',
                      textAlign: TextAlign.left,
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 30, top: 30, right: 60),
                sliver: SliverToBoxAdapter(

                  child: Container(
                    decoration: BoxDecoration(border: Border.all(
                      width: 5.0,
                      color: Color(0xFF1C709A),
                    )),
                    child: DataTable(
                      headingRowColor:
                          MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFF3AB9FF);
                        }, // 헤더 행의 배경색
                      ),
                      columnSpacing: 25.0, // 각 컬럼의 간격을 설정하여 가운데 정렬을 흉내냅니다.
                      columns: [
                        DataColumn(label: Text('No', style: textStyle2)),
                        DataColumn(label: Text('주소', style: textStyle2)),
                        DataColumn(label: Text('가로규격(cm)', style: textStyle2)),
                        DataColumn(label: Text('세로규격(cm)', style: textStyle2)),
                        DataColumn(label: Text('높이규격(cm)', style: textStyle2)),
                        DataColumn(label: Text('상품무게(g)', style: textStyle2)),
                      ],
                      rows: List<DataRow>.generate(goodsList.length, (index) {
                        final good = goodsList[index];
                        return DataRow(
                          cells: [
                            DataCell(Text('${good.goodsId}', style: textStyle)),
                            DataCell(Text(good.area, style: textStyle)),
                            DataCell(Text('${good.width}', style: textStyle)),
                            DataCell(Text('${good.length}', style: textStyle)),
                            DataCell(Text('${good.height}', style: textStyle)),
                            DataCell(Text('${good.weight}g', style: textStyle)),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
