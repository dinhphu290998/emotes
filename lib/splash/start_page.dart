import 'dart:async';
import 'package:emotes/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../home/home_page.dart';
import '../../splash/onboarding.dart';

import '../helpers/ad_helper.dart';
import '../language/language_page.dart';
import '../share/utils/local_storage.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: const Color(0xFF1A1435), // nền tối tím
          body: Stack(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/background/onboarding.png'),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  late Timer _timer;
  void startTimer() {
    const oneSec = const Duration(milliseconds: 2000);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SplashPage()));
        timer.cancel();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    if (!kIsWeb) await MobileAds.instance.initialize();
    await LocalStorageService.init();

    AdHelper.precacheInterstitialAd();
    AdHelper.precacheInterstitialStartAd();
    AdHelper.precacheInterstitialGetStartAd();

    AdHelper.precacheNativeAd();
    AdHelper.precacheNativeLanguageAd();
    AdHelper.precacheNativePage1Ad();
    AdHelper.precacheNativePage2Ad();
    AdHelper.precacheNativePage3Ad();
    AdHelper.precacheNativeInfoAd();

    AdHelper.precacheNativeGunAd();
    AdHelper.precacheNativeCharacterAd();
    AdHelper.precacheNativePetAd();
    AdHelper.precacheNativeEmotesAd();
    AdHelper.precacheNativeLuckyGunAd();
    AdHelper.precacheNativeLuckyCharacterAd();

    AdHelper.precacheBannerAd();
    AdHelper.precacheBannerHomeAd();
    AdHelper.precacheBannerDetailAd();
    AdHelper.precacheBannerLuckyPetAd();

    startTimer();
  }
}
