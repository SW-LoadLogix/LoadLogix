import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardControlPage extends StatefulWidget {
  @override
  _KeyboardControlPageState createState() => _KeyboardControlPageState();
}

String positionText = "Position: x=0, y=0, z=0";
double x = 0, y = 0, z = 0; // 트럭의 초기 위치

class _KeyboardControlPageState extends State<KeyboardControlPage> {
  FocusNode _focusNode = FocusNode();


  void _handleKeyEvent(KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      double increment = 10; // 이동 거리 설정
      setState(() {
        switch (event.logicalKey.keyId) {
          case 0x100070050: // 'W'
            y += increment;
            break;
          case 0x100070051: // 'S'
            y -= increment;
            break;
          case 0x10007004f: // 'D'
            x += increment;
            break;
          case 0x10007004b: // 'A'
            x -= increment;
            break;
          case 0x100070052: // 'Q'
            z += increment;
            break;
          case 0x10007004e: // 'E'
            z -= increment;
            break;
        }
        positionText = "Position: x=$x, y=$y, z=$z";
        // 여기에서 three.js or three.dart 객체의 위치를 업데이트하는 로직을 추가
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3D Object Control"),
      ),
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (node, event) {
          _handleKeyEvent(event);
          return KeyEventResult.handled;
        },
        //onKey: _handleKeyEvent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(positionText, style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Text("Use WASD to move the truck, QE to move up/down", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}