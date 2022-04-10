import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weevo_end_customer/feature/product_details/presentation/pages/product_detail_screen.dart';

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
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'weevoEndCustomer',
        navigatorKey: navigator,

        home: const Splash(),
      ),
    );
  }
}
