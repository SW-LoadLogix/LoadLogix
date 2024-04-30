import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/routes/app_router.dart';
import 'package:load_frontend/views/box_simulation_3d.dart';
import 'package:load_frontend/views/delivery_list.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({ super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('홈 페이지'), // 앱바 타이틀
        ),
        body:
        Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const ListTile(title: Text("여긴 그냥 소개하는 페이지에요.")),
                  const ListTile(title: Text("나중에 바뀔겁니다.")),
                  ElevatedButton(
                    onPressed: (){
                      AutoRouter.of(context).push(SignInUpRoute());
                    },
                    child: const Text('로그인 페이지로 이동'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      AutoRouter.of(context).push(DeliveryListRoute());
                    },
                    child: const Text('적재 전 배송리스트 페이지로 이동'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      AutoRouter.of(context).push(SetTruckSpecificationRoute());
                    },
                    child: const Text('트럭 사이즈 설정 페이지로 이동'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      AutoRouter.of(context).push(BoxSimulation3dRoute());
                      //Navigator.pushNamed(context, '/box-simulation');
                    },
                    child: const Text('박스 시뮬레이션 페이지로 이동'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      AutoRouter.of(context).push(DeliverySimulationMapRoute());
                      // Navigator.pushNamed(context, '/delivery-simulation');
                    },
                    child: const Text('배송 시뮬레이션 (맵) 페이지로 이동'),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}