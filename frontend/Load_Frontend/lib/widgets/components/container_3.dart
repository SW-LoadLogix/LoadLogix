import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/routes/app_router.dart';
import '../../constaints.dart';

class Container3 extends StatelessWidget {
  final bool isHover;

  const Container3({
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
          SizedBox(
            height: 3,
          ),
          // 텍스트 대신 GIF 이미지를 표시
          Container(
            width: 180,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isHover ? Colors.white : primary,
              // boxShadow: [
              //   BoxShadow(
              //     color: Color.fromRGBO(137, 181, 162, 0.56),
              //     blurRadius: 16,
              //     spreadRadius: 0,
              //     offset: Offset(0, -2),
              //   ),
              // ],
            ),
            child: Image.asset(
              'assets/gif/truck43.gif',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              // 버튼 클릭 시 동작할 내용 작성
              AutoRouter.of(context).push(DashboardSimulation3dRoute());
            },
            child: Container(
              width: double.infinity, // 전체 너비
              height: 35,
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
                "적재 시뮬레이션 확인",
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
