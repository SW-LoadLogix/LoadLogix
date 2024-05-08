import 'package:flutter/material.dart';

import '../../constaints.dart';

class Container1 extends StatelessWidget {
  final bool isHover;

  const Container1({
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
            "최신 적재일",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isHover ? Colors.white : primary),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "2024년 05월 07일",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isHover ? Colors.white : primary),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              // 버튼 클릭 시 동작할 내용 작성
            },
            child: Container(
              width: double.infinity, // 전체 너비
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // 버튼의 모서리를 둥글게 만듦
                color: isHover ? Colors.white : primary,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(137, 181, 162, 0.56),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Text(
                "배송대기",
                style: TextStyle(
                  color: isHover ? primary : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
