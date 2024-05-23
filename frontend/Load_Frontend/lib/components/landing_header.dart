import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constaints.dart';
import '../routes/app_router.dart';
import '../stores/user_store.dart';

class LandingHeader extends StatelessWidget {
  final double opacity;

  LandingHeader({this.opacity = 0.0});

  @override
  Widget build(BuildContext context) {
    bool isLogin = Provider.of<UserStore>(context,listen: true).token.isNotEmpty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 30),
            Image.asset("assets/images/logotouse.png", width: 200, height: 200,),
          ],
        ),
        TextButton(
          onPressed: () {
            if (isLogin){
              Provider.of<UserStore>(context, listen: false).deleteToken();
              AutoRouter.of(context).popUntilRoot();
            }else{
              AutoRouter.of(context).popUntilRouteWithPath('/landing');
              AutoRouter.of(context).push(SignInUpRoute());
            }
          },
          child: !isLogin ?Text(
            '로그인',
            style: TextStyle(color: Colors.white)
          ):
            Text(
            '로그아웃',
            style: TextStyle(color: Colors.white)
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
