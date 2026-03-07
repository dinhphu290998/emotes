import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../home/home_page.dart';
import '../../splash/onboarding.dart';

import '../helpers/ad_helper.dart';
import '../language/language_page.dart';
import '../share/utils/local_storage.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final BannerAdController _bannerController = BannerAdController();

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
            Positioned(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "This action may contain ads",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 6,
                          ),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 42,
                            animation: true,
                            animationDuration: 8000,
                            lineHeight: 20.0,
                            percent: 1,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.white,
                            backgroundColor: Colors.grey,
                            onAnimationEnd: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottom: MediaQuery.of(context).padding.bottom + 80,
              left: 0,
            ),
            Positioned(
              child:

                  /// 🔥 Quan trọng: Dùng ValueListenableBuilder để lắng nghe sự kiện load
                  _bannerController.bannerAd != null
                      ? ValueListenableBuilder<bool>(
                          valueListenable: _bannerController.adLoaded,
                          builder: (_, loaded, __) {
                            if (!loaded)
                              return SizedBox(); // Banner chưa load → ẩn

                            return Container(
                              width: MediaQuery.of(context).size.width
                                  .toDouble(),
                              height: _bannerController.bannerAd!.size.height
                                  .toDouble(),
                              child: AdWidget(ad: _bannerController.bannerAd!),
                            );
                          },
                        )
                      : Container(),
              bottom: 0,
              left: 0,
            ),
          ],
        ),
      ),
    );
  }

  late Timer _timer;
  void startTimer() {
    // EasyLoading.show();
    const oneSec = const Duration(milliseconds: 8000);
    _timer = new Timer.periodic(oneSec, (Timer timer) async {
      //code to show interstitial ad and then connect to vpn
      AdHelper.showInterstitialStartAd(onComplete: () async {
        /// Khi chạy xong progress thì chuyển trang
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LanguagePage()),
        );
      });
      timer.cancel();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bannerController.bannerAd = AdHelper.loadBannerAd(
      adController: _bannerController,
      onLoaded: () {
        print("Banner loaded successfully!");
        // update UI hoặc logic khác khi banner load xong
        setState(() {});
      },
    );
    startTimer();
  }
}
