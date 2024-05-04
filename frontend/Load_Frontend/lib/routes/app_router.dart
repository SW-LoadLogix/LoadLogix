import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:load_frontend/views/pages.dart';

part 'app_router.gr.dart';

// flutter packages pub run build_runner build
// flutter packages pub run build_runner watch
// flutter packages pub run build_runner build --delete-conflicting-outputs


@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    RedirectRoute(path: '/', redirectTo: '/home'),
    AutoRoute(path: '/home',page: HomeRoute.page, initial: true),
    AutoRoute(
        path: '/dashboard',
        page: DashboardRoute.page
        // children:[
        //
        // ]
    ),
    AutoRoute(path: '/sign-in-up',page: SignInUpRoute.page),
    AutoRoute(path: '/delivery-list',page: DeliveryListRoute.page),
    AutoRoute(path: '/set-truck-specifications',page: SetTruckSpecificationRoute.page),
    AutoRoute(path: '/box-simulation',page: BoxSimulation3dRoute.page),
    AutoRoute(path: '/delivery-simulation',page: DeliverySimulationMapRoute.page),
    AutoRoute(path: '*', page: NotFoundRoute.page),
  ];
}