import 'package:flutter/material.dart';
import 'package:weevo_end_customer/core/utlis/size_config.dart';
import 'package:weevo_end_customer/core/widgets/custom_text_field.dart';

import '../../../../core/widgets/custom_button.dart';


class TrackShipmentScreen extends StatelessWidget {
  const TrackShipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Image.asset('assets/images/weevo_logo.png'),
          SizedBox(
            width: SizeConfig.screenWidth * .6,
            child: CustomTextField(
              hintText: 'اكتب رقم التتبع',
              fontSize: 15,
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onChange: (v) {
                // ref.read(suggestionsProvider.state).state = [
                //   ...e.data!
                //       .where(
                //         (element) => element.name!
                //         .startsWith(v.toLowerCase().trim()),
                //   )
                //       .toList()
                // ];
                // debugPrint('ll' + suggestions.toString());
                // debugPrint('ll' + e.data!.toString());
              },
            ),
          ),
          CustomBtn(
            showImage: false,
            onChange: ()async {
              // return await _dialog.showOptionDialog(
              //     context: context,
              //     msg: 'هل ترغب بحذف المنتج ؟',
              //     okFun: () async {
              //
              //       // ref.read(deleteProductNotifier.notifier)
              //       //     .deleteProduct(productId: productId!);
              //       // pushAndRemoveUntil(ProductScreen()
              //       // );
              //     },
              //     okMsg: 'نعم',
              //     cancelMsg: 'لا',
              //     cancelFun: () {
              //       return;
              //     });

            },
            width: SizeConfig.screenWidth / 2.3,
            backgroundColor: const Color(0xffFF4040),
            height: SizeConfig.screenHeight * .075,
            text: 'تتبع الشحنه',
            textStyle: const TextStyle(
              color: Colors.white,
              // fontFamily: MainTheme.mainTextFont,
            ),
          ),


        ]),
      ),
    ));
  }
}
