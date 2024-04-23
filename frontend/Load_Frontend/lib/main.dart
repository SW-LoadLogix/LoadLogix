import 'package:flutter/material.dart';
import 'package:load_frontend/set_truck_specifications.dart';
import 'package:load_frontend/sign_in_up.dart';
import 'package:url_strategy/url_strategy.dart';

import 'box_simulation_3d.dart';
import 'delivery_list.dart';
import 'delivery_simulation_map.dart';
import 'home.dart';
import 'not_found_page.dart';

void main() {
  setPathUrlStrategy();  // 주소창에서 # 제거
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Load',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      /*** 라우트 방식 ***/
      routes: {
        '/': (context) => const HomePage(key: Key('home-page')),
        '/sign-in-up': (context) => const SignInUpPage(),
        '/delivery-list': (context) => const DeliveryListPage(),
        '/set-truck-specifications': (context) => const SetTruckSpecificationPage(),
        '/box-simulation': (context) => const BoxSimulation3dPage(),
        '/delivery-simulation': (context) => const DeliverySimulationMapPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const NotFoundPage(),
      ),


      /** onGenerateRoute 방식 **/
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/':
      //       return MaterialPageRoute(builder: (context) => const HomePage());
      //     case '/sign-in-up':
      //       return MaterialPageRoute(builder: (context) => const SignInUpPage());
      //     case '/delivery-list':
      //       return MaterialPageRoute(builder: (context) => const DeliveryListPage());
      //     case '/set-truck-specification':
      //       return MaterialPageRoute(builder: (context) => const SetTruckSpecificationPage());
      //     case '/box-simulation':
      //       return MaterialPageRoute(builder: (context) => const BoxSimulation3dPage());
      //     case '/delivery-simulation':
      //         return MaterialPageRoute(builder: (context) => const DeliverySimulationMapPage());
      //     default:
      //       return MaterialPageRoute(builder: (context) => const NotFoundPage());
      //   }
      // },
    );
  }
}

