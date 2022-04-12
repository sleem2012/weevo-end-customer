import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/themes/screen_utility.dart';
import 'core/utlis/helper.dart';
import 'feature/splash/presentation/pages/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  initializeDateFormatting('ar_EG');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          // For both Android + iOS
          statusBarColor: Colors.transparent,
          // For apps with a light background:
          // For Android (dark icons)
          statusBarIconBrightness: Brightness.dark,
          // For iOS (dark icons)
          statusBarBrightness: Brightness.light,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'weevoEndCustomer',
          navigatorKey: navigator,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                centerTitle: true,
                color: Colors.white,
                elevation: 0.0,
                toolbarHeight: 70.0,
                iconTheme: IconThemeData(color: weevoPrimaryOrangeColor),
                titleTextStyle: TextStyle(
                  color: weevoPrimaryOrangeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: const Color(0xff091147),
                  displayColor: const Color(0xff091147),
                  fontFamily: 'ArabFont',
                ),
          ),
          home: const Splash(),
        ),
      ),
    );
  }
}
