/// Package imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/good_data.dart';
import '../../stores/goods_store.dart';
import 'box_colors.dart';
import 'box_simulation_gobal_setting.dart';

/// Local imports
//import 'sample_view.dart';

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume,
      this.percent, this.index});

  /// Holds x value of the datapoint
  final dynamic x;

  late double? percent;

  late int? index;
  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  late String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

/// Render the pie series with smart labels.
class PieSmartDataLabels extends StatefulWidget {
  /// Creates the pie series with smart labels.
  const PieSmartDataLabels(Key key) : super(key: key);

  @override
  _PieSmartDataLabelsState createState() => _PieSmartDataLabelsState();
}

/// State class of pie series with smart labels.
class _PieSmartDataLabelsState extends State<PieSmartDataLabels> {
  _PieSmartDataLabelsState();

  List<String>? _labelIntersectActionList;
  late String _selectedLabelIntersectAction;
  TooltipBehavior? _tooltipBehavior;
  late LabelIntersectAction _labelIntersectAction;

  //late SampleModel model;

  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Text('Label intersect \naction',
              //     style: TextStyle(
              //       color: Colors.black,//model.textColor,
              //       fontSize: 16,
              //     )),
              //const Padding(padding: EdgeInsets.fromLTRB(55, 0, 0, 0)),
              Container(
                  height: 0,
                  alignment: Alignment.topCenter,
                  child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      //.drawerBackgroundColor,
                      focusColor: Colors.transparent,
                      underline:
                          Container(color: const Color(0xFFBDBDBD), height: 1),
                      value: _selectedLabelIntersectAction,
                      items: _labelIntersectActionList!.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.black)));
                      }).toList(),
                      onChanged: (String? value) {
                        _onLabelIntersectActionChange(value);
                        stateSetter(() {});
                      })),
            ],
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSmartLabelPieChart();
  }

  /// Returns the circular charts with pie series.
  SfCircularChart _buildSmartLabelPieChart() {
    return SfCircularChart(
      title: ChartTitle(text: true ? '' : 'Gold medals count in Rio Olympics'),
      series: _gettSmartLabelPieSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the pie series with smart data labels.
  List<PieSeries<ChartSampleData, String>> _gettSmartLabelPieSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          name: 'RIO',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: '봉명동 446-1', y: 46),
            ChartSampleData(x: '봉명동 446-2', y: 27),
            ChartSampleData(x: '봉명동 446-3', y: 26),
            ChartSampleData(x: '봉명동 446-4', y: 19),
            ChartSampleData(x: '봉명동 446-5', y: 17),
            ChartSampleData(x: '봉명동 446-6', y: 12),
            ChartSampleData(x: '봉명동 446-7', y: 10),
            ChartSampleData(x: '봉명동 446-8', y: 9),
            ChartSampleData(x: '봉명동 446-9', y: 8),
            ChartSampleData(x: '봉명동 446-10', y: 8),
            ChartSampleData(x: '봉명동 446-11', y: 8),
            ChartSampleData(x: '봉명동 446-12', y: 8),
            ChartSampleData(x: '봉명동 446-13', y: 7),
            ChartSampleData(x: '봉명동 446-14', y: 7),
            ChartSampleData(x: '봉명동 446-15', y: 6),
            ChartSampleData(x: '봉명동 446-16', y: 6),
            ChartSampleData(x: '봉명동 446-17', y: 5),
            ChartSampleData(x: '봉명동 446-18', y: 5),
            ChartSampleData(x: '봉명동 446-19', y: 4)
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) =>
              data.x + ': ' + data.y.toString() as String,
          radius: '60%',
          dataLabelSettings: DataLabelSettings(
              margin: EdgeInsets.zero,
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              connectorLineSettings: const ConnectorLineSettings(
                  type: ConnectorType.curve, length: '20%'),
              labelIntersectAction: _labelIntersectAction))
    ];
  }

  @override
  void initState() {
    _selectedLabelIntersectAction = 'shift';
    _labelIntersectActionList = <String>['shift', 'hide', 'none'].toList();
    _labelIntersectAction = LabelIntersectAction.shift;
    _tooltipBehavior = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  void dispose() {
    _labelIntersectActionList!.clear();
    super.dispose();
  }

  /// Method for changing the data label intersect action.
  void _onLabelIntersectActionChange(String? item) {
    setState(() {
      if (item != null) {
        _selectedLabelIntersectAction = item;
        if (_selectedLabelIntersectAction == 'shift') {
          _labelIntersectAction = LabelIntersectAction.shift;
        }
        if (_selectedLabelIntersectAction == 'none') {
          _labelIntersectAction = LabelIntersectAction.none;
        }
        if (_selectedLabelIntersectAction == 'hide') {
          _labelIntersectAction = LabelIntersectAction.hide;
        }
      }
    });
  }
}
/*
/// Render the doughnut series with color mapping.
class DoughnutCustomization extends StatefulWidget {
  /// Render the doughnut series with color mapping.
  const DoughnutCustomization(Key key) : super(key: key);

  @override
  _DoughnutDefaultState createState() => _DoughnutDefaultState();
}

/// State class of doughnut series with color mapping.
class _DoughnutDefaultState extends State<DoughnutCustomization> {
  _DoughnutDefaultState();

  @override
  Widget build(BuildContext context) {
    return _buildDoughnutCustomizationChart();
  }

  /// Returns the circular chart with color mapping doughnut series.
  SfCircularChart _buildDoughnutCustomizationChart() {
    return SfCircularChart(
      annotations: const <CircularChartAnnotation>[
        CircularChartAnnotation(
            widget:
            Text('90%', style: TextStyle(color: Colors.grey, fontSize: 25)))
      ],
      title: ChartTitle(
          text: true ? '' : 'Work progress',
          textStyle: const TextStyle(fontSize: 20)),
      series: _getDoughnutCustomizationSeries(),
    );
  }

  /// Return the list of doughnut series which need to be color mapping.
  List<DoughnutSeries<ChartSampleData, String>>
  _getDoughnutCustomizationSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(
              x: 'A', y: 10, pointColor: const Color.fromRGBO(255, 4, 0, 1)),
          ChartSampleData(
              x: 'B', y: 10, pointColor: const Color.fromRGBO(255, 15, 0, 1)),
          ChartSampleData(
              x: 'C', y: 10, pointColor: const Color.fromRGBO(255, 31, 0, 1)),
          ChartSampleData(
              x: 'D', y: 10, pointColor: const Color.fromRGBO(255, 60, 0, 1)),
          ChartSampleData(
              x: 'E', y: 10, pointColor: const Color.fromRGBO(255, 90, 0, 1)),
          ChartSampleData(
              x: 'F', y: 10, pointColor: const Color.fromRGBO(255, 115, 0, 1)),
          ChartSampleData(
              x: 'G', y: 10, pointColor: const Color.fromRGBO(255, 135, 0, 1)),
          ChartSampleData(
              x: 'H', y: 10, pointColor: const Color.fromRGBO(255, 155, 0, 1)),
          ChartSampleData(
              x: 'I', y: 10, pointColor: const Color.fromRGBO(255, 175, 0, 1)),
          ChartSampleData(
              x: 'J', y: 10, pointColor: const Color.fromRGBO(255, 188, 0, 1)),
          ChartSampleData(
              x: 'K', y: 10, pointColor: const Color.fromRGBO(255, 188, 0, 1)),
          ChartSampleData(
              x: 'L', y: 10, pointColor: const Color.fromRGBO(251, 188, 2, 1)),
          ChartSampleData(
              x: 'M', y: 10, pointColor: const Color.fromRGBO(245, 188, 6, 1)),
          ChartSampleData(
              x: 'N', y: 10, pointColor: const Color.fromRGBO(233, 188, 12, 1)),
          ChartSampleData(
              x: 'O', y: 10, pointColor: const Color.fromRGBO(220, 187, 19, 1)),
          ChartSampleData(
              x: 'P', y: 10, pointColor: const Color.fromRGBO(208, 187, 26, 1)),
          ChartSampleData(
              x: 'Q', y: 10, pointColor: const Color.fromRGBO(193, 187, 34, 1)),
          ChartSampleData(
              x: 'R', y: 10, pointColor: const Color.fromRGBO(177, 186, 43, 1)),
          ChartSampleData(
              x: 'S',
              y: 10,
              pointColor: const Color.fromRGBO(230, 230, 230, 1)),
          ChartSampleData(
              x: 'T', y: 10, pointColor: const Color.fromRGBO(230, 230, 230, 1))
        ],
        radius: '100%',
        strokeColor:Colors.white,
        // model.themeData.colorScheme.brightness == Brightness.light
        //     ? Colors.white
        //     : Colors.black,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,

        /// The property used to apply the color for each douchnut series.
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        dataLabelMapper: (ChartSampleData data, _) => data.x as String,
      ),
    ];
  }
}
*/

/*
class DoughnutElevation extends StatefulWidget {
  /// Creates the doughnut series with center elevation.
  const DoughnutElevation(Key key) : super(key: key);

  @override
  _DoughnutDefaultState createState() => _DoughnutDefaultState();
}

/// State class of doughnut series with center elevation.
class _DoughnutDefaultState extends State<DoughnutElevation> {
  _DoughnutDefaultState();

  @override
  Widget build(BuildContext context) {
    return _buildElevationDoughnutChart();
  }

  /// Returns the circular charts with center elevation dughnut series.
  SfCircularChart _buildElevationDoughnutChart() {
    return SfCircularChart(
      /// It used to set the annotation on circular chart.
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '100%',
            width: '100%',
            widget: PhysicalModel(
              shape: BoxShape.circle,
              elevation: 10,
              color: const Color.fromRGBO(230, 230, 230, 1),
              child: Container(),
            )),
        const CircularChartAnnotation(
            widget: Text('62%',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25)))
      ],
      title: ChartTitle(
          text: false ? '' : 'Progress of a task',
          textStyle: const TextStyle(fontSize: 20)),
      series: _getElevationDoughnutSeries(),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'A',
                y: 62,
                pointColor: const Color.fromRGBO(0, 220, 252, 1)),
            ChartSampleData(
                x: 'B',
                y: 38,
                pointColor: const Color.fromRGBO(230, 230, 230, 1))
          ],
          animationDuration: 0,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }
}

*/

/// Collection of left, right or up, down icon buttons with text widget
class CustomDirectionalButtons extends StatefulWidget {
  /// direction arrows surronding in text widget
  const CustomDirectionalButtons({
    double this.minValue = 0,
    required double this.maxValue,
    required double this.initialValue,
    required ValueChanged<double> this.onChanged,
    double this.step = 1,
    bool this.needNull = false,
    bool this.loop = false,
    this.horizontal = true,
    this.style,
    double this.padding = 0.0,
    Color this.iconColor = Colors.black,
  })  : assert(minValue != null),
        assert(maxValue != null),
        assert(initialValue != null),
        assert(onChanged != null),
        assert(step != null),
        assert(loop != null),
        assert(padding != null),
        assert(iconColor != null);

  // assert(initialValue >= minValue && initialValue <= maxValue),
  // assert(minValue < maxValue);

  /// minimal value
  final double? minValue;

  /// max value
  final double? maxValue;

  /// Initially displayed value in the [CustomDirectionalButtons]
  final double? initialValue;

  /// The callback that is called when the button is tapped
  /// or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final ValueChanged<double>? onChanged;

  /// interval value
  final double? step;

  /// set left,right icons only
  final bool? horizontal;

  /// set after the max value reach, start again from min value
  final bool? loop;

  /// Holds the text widget style
  final TextStyle? style;

  /// The padding around the button's icon.
  /// The entire padded icon will react to input gestures.
  final double? padding;

  /// Color of the icon button
  final Color? iconColor;

  /// Add null instead of 0.
  final bool? needNull;

  @override
  State<StatefulWidget> createState() => _CustomButton();
}

/// Contains the direction (increse/decrease)
enum _CountDirection {
  /// To increase the counter
  Up,

  /// To decrese the counter
  Down
}

class _CustomButton extends State<CustomDirectionalButtons> {
  late double _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue!;
  }

  /// Calculate next value for the CustomDirectionalButtons
  void _count(_CountDirection countDirection) {
    if (countDirection == _CountDirection.Up) {
      // To set the next value after null.
      if (_counter.isNaN) {
        setState(() => _counter = 0 + widget.step!);
      }

      /// Make sure you can't go over `maxValue` unless `loop == true`
      else if (_counter + widget.step! > widget.maxValue!) {
        if (widget.loop!) {
          setState(() {
            /// Calculate the correct value if you go over maxValue in a loop
            final num diff = (_counter + widget.step!) - widget.maxValue!;
            _counter =
                (diff >= 1 ? widget.minValue! + diff - 1 : widget.minValue)!;
          });
        }
      } else {
        if ((widget.initialValue!.isNaN || widget.needNull!) &&
            (_counter + widget.step! == 0)) {
          setState(() => _counter = double.nan);
        } else {
          setState(() => _counter += widget.step!);
        }
      }
    } else {
      if (_counter - widget.step! < widget.minValue!) {
        if (widget.loop!) {
          setState(() {
            final num diff = widget.minValue! - (_counter - widget.step!);
            _counter =
                (diff >= 1 ? widget.maxValue! - diff + 1 : widget.maxValue)!;
          });
        }
      } else {
        if ((widget.initialValue!.isNaN || widget.needNull!) &&
            _counter - widget.step! == 0) {
          setState(() => _counter = double.nan);
        } else if (_counter.isNaN) {
          setState(() => _counter = 0 - widget.step!);
        } else {
          setState(() => _counter -= widget.step!);
        }
      }
    }

    widget.onChanged!(_counter);
  }

  Widget _getCount() {
    return Text(
        widget.initialValue! % 1 == 0 && widget.step! % 1 == 0
            ? ((_counter.isNaN)
                ? 'null'
                : ((widget.needNull!)
                    ? _counter.toInt().toString()
                    : _counter.toStringAsFixed(0)))
            : (_counter.isNaN)
                ? 'null'
                : (widget.needNull!)
                    ? _counter.toInt().toString()
                    : _counter.toStringAsFixed(1),
        style: widget.style ?? Theme.of(context).textTheme.headlineSmall);
  }

  /// Return different widgets for a horizontal and vertical BuildPicker
  Widget _buildCustomButton() {
    return (!widget.horizontal!)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_drop_up),
                padding: EdgeInsets.only(bottom: widget.padding!),
                alignment: Alignment.bottomCenter,
                color: widget.iconColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  _count(_CountDirection.Up);
                },
              ),
              _getCount(),
              IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  padding: EdgeInsets.only(top: widget.padding!),
                  alignment: Alignment.topCenter,
                  color: widget.iconColor,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    _count(_CountDirection.Down);
                  }),
            ],
          )
        : Row(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_left),
                  padding: EdgeInsets.only(right: widget.padding!),
                  color: widget.iconColor,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    _count(_CountDirection.Down);
                  }),
              _getCount(),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                padding: EdgeInsets.only(left: widget.padding!),
                color: widget.iconColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  _count(_CountDirection.Up);
                },
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomButton();
  }
}

class PieTooltipPosition extends StatefulWidget {
  /// Creates the pie series with different tooltip position (auto/pointer).
  const PieTooltipPosition(Key key) : super(key: key);

  @override
  _PieTooltipPositionState createState() => _PieTooltipPositionState();
}

class _PieTooltipPositionState extends State<PieTooltipPosition> {
  _PieTooltipPositionState();

  List<String>? _tooltipPositionList;
  late String _selectedTooltipPosition;
  late TooltipPosition _tooltipPosition;
  late double duration;

  @override
  void initState() {
    _selectedTooltipPosition = 'auto';
    _tooltipPosition = TooltipPosition.auto;
    duration = 1;
    _tooltipPositionList = <String>['auto', 'pointer'].toList();
    super.initState();
  }

  // @override
  // Widget buildSettings(BuildContext context) {
  //   return StatefulBuilder(
  //       builder: (BuildContext context, StateSetter stateSetter) {
  //         return ListView(
  //           shrinkWrap: true,
  //           children: <Widget>[
  //             // Row(
  //             //   children: <Widget>[
  //             //     Text('Tooltip position',
  //             //         style: TextStyle(
  //             //           color: Colors.black,
  //             //           fontSize: 16,
  //             //         )),
  //             //     Container(
  //             //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  //             //       height: 50,
  //             //       alignment: Alignment.bottomLeft,
  //             //       child: DropdownButton<String>(
  //             //           dropdownColor: Colors.white,
  //             //           focusColor: Colors.transparent,
  //             //           underline:
  //             //           Container(color: const Color(0xFFBDBDBD), height: 1),
  //             //           value: _selectedTooltipPosition,
  //             //           items: _tooltipPositionList!.map((String value) {
  //             //             return DropdownMenuItem<String>(
  //             //                 value: (value != null) ? value : 'auto',
  //             //                 child: Text(value,
  //             //                     style: TextStyle(color: Colors.black)));
  //             //           }).toList(),
  //             //           onChanged: (dynamic value) {
  //             //             setState(() {
  //             //               onPositionTypeChange(value.toString());
  //             //               stateSetter(() {});
  //             //             });
  //             //           }),
  //             //     ),
  //             //   ],
  //             // ),
  //             Row(
  //               children: <Widget>[
  //                 // Text('Hide delay',
  //                 //     style: TextStyle(fontSize: 10.0, color: Colors.black)),
  //                 Container(
  //                   //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  //                   child: CustomDirectionalButtons(
  //                     minValue: 1,
  //                     maxValue: 10,
  //                     initialValue: duration,
  //                     onChanged: (double val) => setState(() {
  //                       duration = val;
  //                     }),
  //                     step: 2,
  //                     loop: true,
  //                     iconColor: Colors.black,
  //                     style: TextStyle(fontSize: 10.0, color: Colors.black),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    //final goodsStore = Provider.of<GoodsStore>(context, listen: true);

    //final groupedGoods= Provider.of<GoodsStore>(context, listen: true).getgoodsGroupedByBuildingId();

    return _buildPieTooltipPositionChart();
  }

  SfCircularChart _buildPieTooltipPositionChart() {
    return SfCircularChart(
      margin: const EdgeInsets.all(10),
      // backgroundColor: Colors.white,
      // borderWidth: ,
      // borderColor: ,

      // title: ChartTitle(
      //     text: false
      //         ? ''
      //         : 'Various countries population density and area'),
      legend: Legend(
          textStyle: TextStyle(
            fontSize: 10,
          ),
          position: LegendPosition.right,
          isVisible: false ? false : true,
          padding: 5,
          itemPadding: 5,
          isResponsive: false,
          alignment: ChartAlignment.center,
          orientation: LegendItemOrientation.vertical,
          overflowMode: LegendItemOverflowMode.scroll),
      series: _getPieSeries(),

      /// To enabe the tooltip and its behaviour.
      tooltipBehavior: TooltipBehavior(
        enable: true,
        tooltipPosition: _tooltipPosition,
        duration: duration * 1000,
      ),
    );
  }

  List<PieSeries<ChartSampleData, String>> _getPieSeries() {
    final goodsStore = Provider.of<GoodsStore>(context, listen: false);

    Map<int, List<GoodsData>> groupedGoods =
        context.watch<GoodsStore>().goodsGroupedByBuildingId;
    final ggoods = goodsStore.goods;
    final buildingChecked = goodsStore.buildingChecked;

    List<ChartSampleData> data = [];


    if (groupedGoods.isNotEmpty) {
      groupedGoods.forEach((key, value) {
        if (buildingChecked.isEmpty) return;
        if (buildingChecked[key] == false) return;
        if (goodsStore.numberMapping.isEmpty) return;
        double percent = (value.length / ggoods.length) * 100;
        data.add(
            ChartSampleData(
                x: value[0].buildingName,
                y: value.length,
                percent: percent,
                pointColor: distinctColors[ goodsStore.numberMapping[key]!]
            )
        );
      });
    }


    data.sort((a, b) => b.percent!.compareTo(a.percent!));

    if (data.isNotEmpty) {
      double highestPercent = data[0].percent!;
      for (int i = 0; i < data.length; i++) {
        data[i].percent = (data[i].percent! / highestPercent) * 100;
        data[i].text = '${data[i].percent!.toStringAsFixed(0)}%';
      }
    }

    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          dataSource: data,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.y.toString() as String,
          startAngle: 100,
          endAngle: 100,
          pointRadiusMapper: (ChartSampleData data, _) => data.text,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.inside))
    ];

    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(x: '봉명동 446-1', y: 46, text: '100%'),
            ChartSampleData(x: '봉명동 446-2', y: 27, text: '100%'),
            ChartSampleData(x: '봉명동 446-3', y: 26, text: '100%'),
            ChartSampleData(x: '봉명동 446-4', y: 19, text: '100%'),
            ChartSampleData(x: '봉명동 446-5', y: 17, text: '100%'),
            ChartSampleData(x: '봉명동 446-6', y: 12, text: '100%'),
            ChartSampleData(x: '봉명동 446-7', y: 10, text: '100%'),
            ChartSampleData(x: '봉명동 446-8', y: 9, text: '100%'),
            ChartSampleData(x: '봉명동 446-9', y: 8, text: '100%'),
            ChartSampleData(x: '봉명동 446-10', y: 8, text: '100%'),
            ChartSampleData(x: '봉명동 446-11', y: 8, text: '100%'),
            ChartSampleData(x: '봉명동 446-12', y: 8, text: '100%'),
            ChartSampleData(x: '봉명동 446-13', y: 7, text: '100%'),
            ChartSampleData(x: '봉명동 446-14', y: 7, text: '100%'),
            ChartSampleData(x: '봉명동 446-15', y: 6, text: '100%'),
            ChartSampleData(x: '봉명동 446-16', y: 6, text: '100%'),
            ChartSampleData(x: '봉명동 446-17', y: 5, text: '100%'),
            ChartSampleData(x: '봉명동 446-18', y: 5, text: '100%'),
            ChartSampleData(x: '봉명동 446-19', y: 4, text: '100%')

            // ChartSampleData(x: 'Argentina', y: 505370, text: '45%'),
            // ChartSampleData(x: 'Belgium', y: 551500, text: '53.7%'),
            // ChartSampleData(x: 'Cuba', y: 312685, text: '59.6%'),
            // ChartSampleData(x: 'Dominican', y: 350000, text: '72.5%'),
            // ChartSampleData(x: 'Egypt', y: 301000, text: '85.8%'),
            // ChartSampleData(x: 'Kazakhstan', y: 300000, text: '90.5%'),
            // ChartSampleData(x: 'Somalia', y: 357022, text: '95.6%')
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.x as String,
          startAngle: 100,
          endAngle: 100,
          pointRadiusMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(
              isVisible: false, labelPosition: ChartDataLabelPosition.outside))
    ];
  }

  void onPositionTypeChange(String item) {
    _selectedTooltipPosition = item;
    if (_selectedTooltipPosition == 'auto') {
      _tooltipPosition = TooltipPosition.auto;
    }
    if (_selectedTooltipPosition == 'pointer') {
      _tooltipPosition = TooltipPosition.pointer;
    }
    setState(() {
      /// update the tooltip position changes
    });
  }

  @override
  void dispose() {
    _tooltipPositionList!.clear();
    super.dispose();
  }
}
