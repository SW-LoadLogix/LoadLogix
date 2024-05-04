import 'package:flutter/material.dart';
import 'package:load_frontend/routes/app_router.dart';
import 'package:load_frontend/themes/login_style.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'components/nav_rail.dart';
import 'views/pages.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/views/dashboard.dart';
import 'package:load_frontend/constaints.dart';

// class SidebarState extends ChangeNotifier {
//   int _selectedIndex = 0;
//   int get selectedIndex => _selectedIndex;
//
//   void setSelectedIndex(int index) {
//     _selectedIndex = index;
//     notifyListeners(); // 변경 사항을 위젯에 알림
//   }
// }
// 전체 글꼴 설정
// ThemeData loginTheme = ThemeData(
//   fontFamily: 'IBMPlexMono',
// );
void main() {
  setPathUrlStrategy();  // 주소창에서 # 제거
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: 'Nunito',
          primaryColor: primary,
          textTheme: TextTheme().apply(bodyColor: textColor)
      ),
      routerConfig: appRouter.config(),
    );
  }
}