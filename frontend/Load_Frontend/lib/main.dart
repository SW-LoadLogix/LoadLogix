import 'package:flutter/material.dart';
import 'package:load_frontend/routes/app_router.dart';
import 'package:load_frontend/themes/login_style.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:load_frontend/constaints.dart';


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
      theme:loginTheme,
      routerConfig: appRouter.config(),
    );
  }
}