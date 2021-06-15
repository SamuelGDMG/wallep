import 'package:finance/screens/Login/Login.dart';
import 'package:finance/utils/StorageUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  void _onIntroEnd(context) {
    Get.to(() => Login());
  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: 'onBoardingPageTitle1'.tr,
          bodyWidget: Text('onBoardingPageBody1'.tr, style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.justify),
          image: _buildImage('paper'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'onBoardingPageTitle2'.tr,
          bodyWidget: Text('onBoardingPageBody2'.tr, style: TextStyle(color: Colors.black, fontSize: 18,), textAlign: TextAlign.justify,),
          image: _buildImage('first'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('onBoardingPageSkipButton'.tr),
      next: const Icon(Icons.arrow_forward),
      done: Text('onBoardingPageEnterButton'.tr, style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
