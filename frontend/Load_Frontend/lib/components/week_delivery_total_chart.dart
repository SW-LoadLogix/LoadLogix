import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/models/goods_total_data.dart';
import 'package:load_frontend/services/delivery_service.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:provider/provider.dart';

class WeekDeliveryTotalChart extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<WeekDeliveryTotalChart> {
  int touchedIndex = -1;
  GoodsTotalDataWrapper _goodsTotalDataWrapper = GoodsTotalDataWrapper(amount: [
    GoodsTotalData(date: DateTime.now(), total: 0),
    GoodsTotalData(date: DateTime.now(), total: 0),
    GoodsTotalData(date: DateTime.now(), total: 0),
    GoodsTotalData(date: DateTime.now(), total: 0),
    GoodsTotalData(date: DateTime.now(), total: 0),
    GoodsTotalData(date: DateTime.now(), total: 0),
    GoodsTotalData(date: DateTime.now(), total: 0),
  ]);

  @override
  void initState() {
    fetchGoodsTotalDataWrapperFromService();
    super.initState();
  }

  Future<void> fetchGoodsTotalDataWrapperFromService() async{
    UserStore us = Provider.of<UserStore>(context, listen: false);
    try{
      GoodsTotalDataWrapper goodsTotalDataWrapper = (await DeliveryService().fetchGoodsTotal(us.token))!;
      setState(()  {
        _goodsTotalDataWrapper = goodsTotalDataWrapper;
        print (_goodsTotalDataWrapper);
      });
    }catch(e){
      print (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, right: 24, bottom: 24),
          child: BarChart(
            mainBarData(),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 18,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Colors.transparent],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, _goodsTotalDataWrapper.amount[0].total+ 1 as double, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, _goodsTotalDataWrapper.amount[1].total + 1as double, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, _goodsTotalDataWrapper.amount[2].total + 1as double, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, _goodsTotalDataWrapper.amount[3].total+ 1 as double, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, _goodsTotalDataWrapper.amount[4].total+ 1 as double, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, _goodsTotalDataWrapper.amount[5].total+ 1 as double, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, _goodsTotalDataWrapper.amount[6].total+ 1 as double, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mon';
              case 1:
                return 'Tue';
              case 2:
                return 'Wed';
              case 3:
                return 'Thur';
              case 4:
                return 'Frid';
              case 5:
                return 'Sat';
              case 6:
                return 'Sun';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          reservedSize: 40,
          margin: 20,
          interval: 1,
          getTitles: (value) {
            if (value == 0) {
              return '0';
            } else if (value == 50) {
              return '50';
            } else if (value == 100) {
              return '100';
            } else if (value == 150) {
              return '150';
            } else {
              return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }
}
