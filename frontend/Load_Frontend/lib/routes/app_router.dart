import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:load_frontend/views/pages.dart';

part 'app_router.gr.dart';
//import 'app_router.gr.dart';

// flutter packages pub run build_runner build

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/',page: HomeRoute.page, initial: true),
    AutoRoute(path: '/sign-in-up',page: SignInUpRoute.page),
    AutoRoute(path: '/delivery-list',page: DeliveryListRoute.page),
    AutoRoute(path: '/set-truck-specifications',page: SetTruckSpecificationRoute.page),
    AutoRoute(path: '/box-simulation',page: BoxSimulation3dRoute.page),
    AutoRoute(path: '/delivery-simulation',page: DeliverySimulationMapRoute.page),
    AutoRoute(path: '/box-simulation-v2', page: BoxSimulation3dSecondRoute.page),
    // add your routes here
  ];
}