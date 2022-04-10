import 'package:flutter/material.dart';
import 'package:weevo_end_customer/core/utlis/size_config.dart';
import 'package:weevo_end_customer/feature/splash/presentation/widgets/slide.dart';


class SlideItems extends StatelessWidget {
  final int index;

   const SlideItems(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(index==1)
            SizedBox(height: SizeConfig.screenHeight*.17,),
          Image.asset(
            slideList[index].image!,
            width: SizeConfig.screenWidth,
          ),
          if(index==1)
            SizedBox(height: SizeConfig.screenHeight*.1,),

            Padding(
              padding:  EdgeInsets.only(right:  SizeConfig.screenWidth*.15),
              child: Text(
              slideList[index].title!,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
          ),
            ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding:  EdgeInsets.only(right:  SizeConfig.screenWidth*.15),
            child: Text(
              slideList[index].desc!,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
          ),

        ],
      ),
    );
  }
}
