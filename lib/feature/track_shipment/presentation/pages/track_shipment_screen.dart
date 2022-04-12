import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weevo_end_customer/core/themes/screen_utility.dart';
import 'package:weevo_end_customer/core/utlis/helper.dart';
import 'package:weevo_end_customer/core/utlis/size_config.dart';
import 'package:weevo_end_customer/core/widgets/custom_text_field.dart';
import 'package:weevo_end_customer/feature/shipment_details/presentation/pages/shipment_detail_screen.dart';
import '../../../../core/widgets/action_dialog.dart';
import '../../../../core/widgets/custom_button.dart';

class TrackShipmentScreen extends StatelessWidget {
  const TrackShipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int? shipmentId;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


    return WillPopScope(
    onWillPop: () async {
      showDialog(
        context: context,
        builder: (context) => ActionDialog(
          title: 'الخروج من التطبيق',
          content: 'هل تود الخروج من التطبيق',
          approveAction: 'نعم',
          cancelAction: 'لا',
          onApproveClick: () {
            Navigator.pop(context);
            SystemNavigator.pop();
          },
          onCancelClick: () {
            Navigator.pop(context);
          },
        ),
      );
      return false;
    },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: SizeConfig.screenHeight * .44,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Color(0xffF3EDDC),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenWidth * .1,
                                    horizontal: SizeConfig.screenWidth * .05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/images/profile.png'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('اهلا بيك\nمستخدم ويفو',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            textDirection: TextDirection.rtl),
                                      ],
                                    ),
                                    Image.asset('assets/images/weevo_logo.png'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.screenWidth * .055),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'يمكنك تتبع شحنتك\nعن طريق كتابة كود التتبع\nالمرسل اليك من تاجر ويفو',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: SizeConfig.screenWidth * .05),
                                    ),
                                    Image.asset('assets/images/circle_map.png',
                                        width: SizeConfig.screenWidth * .36),
                                  ],
                                ),
                              )
                            ],
                          )),
                      Positioned(
                        bottom: -SizeConfig.screenHeight * .044,
                        width: SizeConfig.screenWidth,
                        child: Form(
                          key: _formKey,
                          child: CustomTextField(
                            labelText: 'اكتب رقم التتبع',
                            fillColor: Colors.white,
                            filled: true,
                            // hintText: 'اكتب رقم التتبع',
                            fontSize: 15,
                            enableText: true,
                            horizontalPadding: .05,
                            verticalPadding: .03,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'ادخل رقم الشحنه';
                              }
                              return null;
                            },
                            suffixIcon: Padding(
                              padding:
                                  EdgeInsets.all(SizeConfig.screenWidth * .023),
                              child: Image.asset('assets/images/search_icon.png'),
                            ),
                            onChange: (v) {
                              shipmentId = int.parse(v);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .037,
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.screenWidth * .03),
                    child: CustomBtn(
                      showImage: false,
                      onChange: () async {
                        if (_formKey.currentState!.validate()) {
                          push(ShipmentDetailsScreen(shipmentId: shipmentId));

                        }
                      },
                      backgroundColor: weevoPrimaryOrangeColor,
                      height: SizeConfig.screenHeight * .075,
                      text: 'تتبع الشحنه',
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold
                          // fontFamily: MainTheme.mainTextFont,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .3,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          "assets/images/slider_image.png",
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: 2,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          margin:
                              EdgeInsets.only(top: SizeConfig.screenHeight * .2),
                          builder: DotSwiperPaginationBuilder(
                            activeColor: weevoPrimaryOrangeColor,
                          )),
                      autoplay: true,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
