import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../constaints.dart';
import '../routes/app_router.dart';

class LandingHeader extends StatelessWidget {
  final double opacity;

  LandingHeader({this.opacity = 0.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'LOADLOGIX',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            AutoRouter.of(context).popUntilRouteWithPath('/landing');
            AutoRouter.of(context).push(SignInUpRoute());
          },
          child: Text(
            '로그인',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );

    // return Container(
    //   height: 65,
    //   color: primary.withOpacity(opacity),
    //   padding: EdgeInsets.symmetric(horizontal: 16.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           Icon(Icons.home, color: Colors.white),
    //           SizedBox(width: 10),
    //           Text(
    //             'LOADLOGIX',
    //             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    //           ),
    //         ],
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           // 로그인 버튼 클릭 시 동작
    //         },
    //         child: Text(
    //           '로그인',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
