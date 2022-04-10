import 'package:flutter/cupertino.dart';

class Slide {
  String? title;
  String? image;
  String? desc;

  Slide({
    @required this.image,
    @required this.desc,
    @required this.title,
  });
}

// ignore: non_constant_identifier_names
final slideList = [
  Slide(
      image: 'assets/images/on_boarding_1.png',
      desc: "تقدر دلوقتي تشوف شحنتك وصلت فين \n عن طريق كود التتبع",
      title: "تتبع طلبك"),
  Slide(
      image: 'assets/images/on_boarding_2.png',
      desc: "تقدر دلوقتي تعرف مين هيوصل شحنتك",
      title: "تتبع طلبك"),

];

