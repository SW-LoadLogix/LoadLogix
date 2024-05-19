import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:load_frontend/routes/app_router.dart';
import 'package:load_frontend/stores/delivery_store.dart';
import 'package:load_frontend/stores/box_store.dart';
import 'package:load_frontend/stores/goods_store.dart';
import 'package:load_frontend/stores/worker_store.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:load_frontend/themes/login_style.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/themes/theme_version2.dart';



void main() async{
  setPathUrlStrategy();  // 주소창에서 # 제거
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();

    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => GoodsStore()),
        ChangeNotifierProvider(create: (context) => WorkerStore()),
         ChangeNotifierProvider(create: (context) => UserStore()),
        ChangeNotifierProvider(create: (context) => DeliveryStore()),
        ChangeNotifierProvider(create: (context) => BoxStore()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        //theme: themeVersion2.light(),
        theme:loginTheme,
        routerConfig: appRouter.config(),
      )
    );
  }
}