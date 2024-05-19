import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constaints.dart';

SfRangeValues _heightFloorValues = SfRangeValues(0.0, 100.0);
double transparencyValuePercent = 80.0;
double boxStepPercent = 50.0;
double heightFloorValuesLowPercent = 0.0;
double heightFloorValuesHighPercent = 100.0;

class SimulationController extends StatefulWidget {
  const SimulationController({Key? key}) : super(key: key);

  @override
  _SimulationControllerState createState() => _SimulationControllerState();
}

class _SimulationControllerState extends State<SimulationController> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryColor: primary,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryLight,
          ),
          //accentColor: primaryLight,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: textColor),
          ),
          sliderTheme: SliderThemeData(
            activeTrackColor: primaryAncient,
            inactiveTrackColor: primaryLight,
            trackHeight: 4.0,
            thumbColor: primary,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayColor: primary.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            activeTickMarkColor: primaryAncient,
            inactiveTickMarkColor: primaryLight,
          ),
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 24,
            child: Text('택배 적재 높이별 보기'),
          ),
          SfRangeSlider(
            min: 0.0,
            max: 100.0,
            values: _heightFloorValues,
            interval: 20,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            onChanged: (SfRangeValues values) {
              setState(() {
                heightFloorValuesLowPercent = _heightFloorValues.start;
                heightFloorValuesHighPercent = _heightFloorValues.end;
                _heightFloorValues = values;
              });
            },
          ),
          Container(height: 10),
          Container(
            alignment: Alignment.center,
            height: 24,
            child: Text('투명도'),
          ),
          SfSlider(
            min: 0.0,
            max: 100.0,
            value: transparencyValuePercent,
            interval: 20,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            onChanged: (dynamic newValue) {
              setState(() {
                transparencyValuePercent = newValue;
              });
            },
          ),
          Container(height: 10),
          // Container(
          //   alignment: Alignment.center,
          //   height: 24,
          //   child: Text('Simulation Speed'),
          // ),
          // SfSlider(
          //   min: 0,
          //   max: 100,
          //   value: boxStepPercent,
          //   interval: 20,
          //   showTicks: true,
          //   showLabels: true,
          //   enableTooltip: true,
          //   minorTicksPerInterval: 1,
          //   onChanged: (dynamic newValue) {
          //     setState(() {
          //       boxStepPercent = newValue;
          //     });
          //   },
          // ),
          Container(height: 10),
        ]));
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
//
// SfRangeValues _heightFloorValues = SfRangeValues(0.0, 100.0);
// double transparencyValuePercent = 60.0;
// double boxStepPercent = 50.0;
// double heightFloorValuesLowPercent = 0.0;
// double heightFloorValuesHighPercent = 100.0;
//
// class SimulationController extends StatefulWidget {
//   const SimulationController({Key? key}) : super(key: key);
//
//   @override
//   _SimulationControllerState createState() => _SimulationControllerState();
// }
//
// class _SimulationControllerState extends State<SimulationController> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Column(children: [
//           Container(
//             alignment: Alignment.center,
//             height: 24,
//             child: Text('Box Floor Height'),
//           ),
//           SfRangeSlider(
//             min: 0.0,
//             max: 100.0,
//             values: _heightFloorValues,
//             interval: 20,
//             showTicks: true,
//             showLabels: true,
//             enableTooltip: true,
//             minorTicksPerInterval: 1,
//             onChanged: (SfRangeValues values) {
//               setState(() {
//                 heightFloorValuesLowPercent =
//                     _heightFloorValues.start;
//                 heightFloorValuesHighPercent =
//                     _heightFloorValues.end;
//                 _heightFloorValues = values;
//               });
//             },
//           ),
//           Container(height: 10),
//           Container(
//             alignment: Alignment.center,
//             height: 24,
//             child: Text('Transparency'),
//           ),
//           SfSlider(
//             min: 0.0,
//             max: 100.0,
//             value: transparencyValuePercent,
//             interval: 20,
//             showTicks: true,
//             showLabels: true,
//             enableTooltip: true,
//             minorTicksPerInterval: 1,
//             onChanged: (dynamic newValue) {
//               setState(() {
//                 transparencyValuePercent = newValue;
//               });
//             },
//           ),
//           Container(height: 10),
//           Container(
//             alignment: Alignment.center,
//             height: 24,
//             child: Text('Simulation Speed'),
//           ),
//           SfSlider(
//             min: 0,
//             max: 100,
//             value: boxStepPercent,
//             interval: 20,
//             showTicks: true,
//             showLabels: true,
//             enableTooltip: true,
//             minorTicksPerInterval: 1,
//             onChanged: (dynamic newValue) {
//               setState(() {
//                 boxStepPercent = newValue;
//               });
//             },
//           ),
//           Container(height: 10),
//         ]),
//       ],
//     );
//   }
// }
