import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';

import 'components/container_1.dart';
import 'components/container_2.dart';
import 'components/container_3.dart';
import 'components/container_4.dart';

class StatusCard extends StatefulWidget {
  final int index;
  const StatusCard(this.index);

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        this.setState(() {
          this._isHover = true;
        });
      },
      onExit: (e) {
        this.setState(() {
          this._isHover = false;
        });
      },
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(137, 181, 162, 0.56),
                  blurRadius: 16,
                  spreadRadius: 0,
                  offset: Offset(0, -2))
            ],
            borderRadius: BorderRadius.circular(16),
            color: _isHover ? primary : Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _eachComponent(),
        ),
      ),
    );
  }

  Widget _eachComponent() {
    switch (widget.index % 4) {
      case 0:
        return Container1(isHover: _isHover);
      case 1:
        return Container2(isHover: _isHover);
      case 2:
        return Container3(isHover: _isHover);
      case 3:
        return Container4(isHover: _isHover);

      // return Container(
      //   color: Colors.yellow, // 예시용 색상
      //   child: Center(child: Text('Component 4')),
      // );
      default:
        return Container(); // 기본적으로 빈 컨테이너 반환
    }
  }
}
