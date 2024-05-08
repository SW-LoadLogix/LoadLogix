import 'package:flutter/material.dart';

import '../../constaints.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class Container2 extends StatelessWidget {
  final bool isHover;

  const Container2({
    Key? key,
    required this.isHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "적재 Status",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isHover ? Colors.white : primary),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "적재 알고리즘을 위한 배송 상품이 준비중입니다",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isHover ? Colors.white : primary),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 18,
          ),
          Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Colors.blue,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
