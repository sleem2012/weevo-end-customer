import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weevo_end_customer/core/utlis/helper.dart';
import 'package:weevo_end_customer/core/utlis/size_config.dart';
import 'package:weevo_end_customer/feature/splash/presentation/pages/on_boarding_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);


  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4)).then((value) => pushAndRemoveUntil(const OnBoarding()));



  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            'assets/images/weevo_splash_screen_icon.gif',
            width: size.width,
            height: size.height,
            fit: BoxFit.fitHeight,

          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(

                       '',
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


}
