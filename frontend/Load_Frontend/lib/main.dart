import 'package:flutter/material.dart';
import 'package:load_frontend/themes/login_style.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'components/nav_rail.dart';
import 'pages/pages.dart';

class SidebarState extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // 변경 사항을 위젯에 알림
  }
}
// 전체 글꼴 설정
// ThemeData loginTheme = ThemeData(
//   fontFamily: 'IBMPlexMono',
// );
void main() {
  setPathUrlStrategy();  // 주소창에서 # 제거
  runApp(ChangeNotifierProvider(
    create: (context) => SidebarState(), // SidebarState 인스턴스 생성
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Load',
      // theme: ThemeData(
      //   useMaterial3: true,
      // ),

      theme: loginTheme,

      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',

      onGenerateRoute: (RouteSettings settings) {
        var uri = Uri.parse(settings.name ?? '');
        var path = uri.path;
        var dataParam = uri.queryParameters['data'];

        // print('Path: $path');
        // print('Data parameter: $dataParam');

        return MaterialPageRoute(builder: (context) {
          return BouncingScrollWrapper.builder(
              context, buildPage(path ?? '', dataParam),
              dragWithMouse: true);
        });
      },
      debugShowCheckedModeBanner: false,

      /*** 라우트 방식 ***/
      routes: {
        '/': (context) => const HomePage(key: Key('home-page')),
        '/sign-in-up': (context) => const SignInUpPage(),
        '/delivery-list': (context) => const DeliveryListPage(),
        '/set-truck-specifications': (context) => SetTruckSpecificationPage(),
        '/box-simulation': (context) => BoxSimulation3dPage(),
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
  Widget buildPage(String name, String? params) {
    switch (name) {
      case '/':
        return const ResponsiveBreakpoints(breakpoints: [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: HomePage( key: Key('home-page')));
      case '/set-truck-specifications':
        return ResponsiveBreakpoints(breakpoints: [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: SetTruckSpecificationPage());
      case '/box-simulation':
        return ResponsiveBreakpoints(breakpoints: const [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: BoxSimulation3dPage());
      case '/delivery-simulation':
        return const ResponsiveBreakpoints(breakpoints: [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: DeliverySimulationMapPage());
      case '/delivery-list':
        return const ResponsiveBreakpoints(breakpoints: [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: DeliveryListPage());
      case '/sign-in-up':
        return const ResponsiveBreakpoints(breakpoints: [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: SignInUpPage());
    // case TypographyPage.name:
    //   return const TypographyPage();
      default:
        return const ResponsiveBreakpoints(
          breakpoints: [
            Breakpoint(start: 0, end: 480, name: MOBILE),
            Breakpoint(start: 481, end: 1200, name: TABLET),
            Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
          ],
          child: NotFoundPage(),
        );
    }
  }
}