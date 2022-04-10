import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weevo_end_customer/core/utlis/helper.dart';
import 'package:weevo_end_customer/feature/track_shipment/presentation/pages/track_shipment_screen.dart';

import '../../../../core/themes/screen_utility.dart';
import '../../../../core/widgets/action_dialog.dart';
import '../widgets/slide.dart';
import '../widgets/slide_dotes.dart';
import '../widgets/slide_items.dart';


class OnBoarding extends StatefulWidget {

  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        switch (_currentPage) {
          case 0:
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
            break;
          case 1:
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
            break;
          case 2:
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: slideList.length,
                  itemBuilder: (context, i) => SlideItems(i),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Row(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(0, 0),
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        onPressed: () {
                         pushReplacement(const TrackShipmentScreen());
                        },
                        child: const Text(
                          'تخطي',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          slideList.length,
                              (i) => i == _currentPage
                              ? const SlideDotes(true)
                              : const SlideDotes(false),
                        ),
                      ),
                      flex: 3,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(0, 0),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              weevoPrimaryBlueColor,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(10.0))),
                        onPressed: () {
                          if (_currentPage == slideList.length - 1) {
                            pushReplacement(const TrackShipmentScreen());

                          }
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 25.0,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
