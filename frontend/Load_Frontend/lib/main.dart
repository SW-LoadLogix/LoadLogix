import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'components/nav_rail.dart';
import 'pages/pages.dart';

void main() {
  setPathUrlStrategy();  // 주소창에서 # 제거
  runApp(MyApp());
}

class SidebarState extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // 변경 사항을 위젯에 알림
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SidebarState(),
      child: MaterialApp(
        title: 'Load',
        builder: (context, child) =>
            ResponsiveBreakpoints.builder(
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
          return MaterialPageRoute(builder: (context) {
            return BouncingScrollWrapper.builder(
              context,
              buildPage(settings.name ?? ''),
              dragWithMouse: true,
            );
          });
        },
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) =>
              Scaffold(
                body: Row(
                  children: [
                    const MyNav(),
                    Expanded(
                      child: Navigator(
                        onGenerateRoute: (settings) {
                          return MaterialPageRoute(
                            builder: (context) =>
                                buildPage(settings.name ?? ''),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          '/sign-in-up': (context) => const SignInUpPage(),
          '/delivery-list': (context) => const DeliveryListPage(),
          '/set-truck-specifications': (
              context) => SetTruckSpecificationPage(),
          '/box-simulation': (context) => const BoxSimulation3dPage(),
          '/delivery-simulation': (
              context) => const DeliverySimulationMapPage(),
        },
        onUnknownRoute: (settings) =>
            MaterialPageRoute(
              builder: (context) => const NotFoundPage(),
            ),
      ),
    );
  }

  Widget buildPage(String name) {
    switch (name) {
      case '/':
        return const HomePage(key: Key('home-page'));
      case '/set-truck-specifications':
        return SetTruckSpecificationPage();
      case '/box-simulation':
        return const BoxSimulation3dPage();
      case '/delivery-simulation':
        return const DeliverySimulationMapPage();
      case '/delivery-list':
        return const DeliveryListPage();
      case '/sign-in-up':
        return const SignInUpPage();
      default:
        return const NotFoundPage();
    }
  }
}