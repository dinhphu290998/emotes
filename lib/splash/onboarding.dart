import 'dart:async';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../guide/guide_page.dart';
import '../../home/home_page.dart';

import '../helpers/ad_helper.dart';
import '../language/language_page.dart';
import '../share/extensions/color_extensions.dart';
import '../share/widgets/animation_widget.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final BannerAdController _bannerController = BannerAdController();

  final fb = FacebookAppEvents();

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
                      image: AssetImage('assets/background/start.png'),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Welcome To",
                            textAlign: TextAlign
                                .center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight
                                    .w600,
                                color: Colors
                                    .white),
                          ),),
                        Center(
                          child: Text(
                            "EMOTES VIEWER",
                            textAlign: TextAlign
                                .center,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight:
                                FontWeight
                                    .w900,
                                color: Colors
                                    .white),
                          ),),
                        Center(
                          child: Text(
                            "Take your gameplay to the next level with \n emotes, gun skins, pro controls, and more",
                            textAlign: TextAlign
                                .center,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w600,
                                color: Colors
                                    .white),
                          ),),
                        SizedBox(height: 32,),
                        // AdManager.instance.isBannerAdSplashLoaded ? Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 12),
                        //   child: AnimatedTapWrapper(
                        //     onTap: () {
                        //       EasyLoading.show();
                        //       AdManager.instance.loadInterstitialAdStart(
                        //         onAdDismissed: () {
                        //           EasyLoading.dismiss();
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(builder: (context) => GuidePage()),
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: Center(
                        //       child: Container(
                        //         height: 50,
                        //         width: MediaQuery.of(context).size.width * 3/4,
                        //         decoration: BoxDecoration(
                        //             color: HexColor.fromHex("#FF9700"),
                        //             borderRadius:
                        //             BorderRadius
                        //                 .circular(
                        //                 12)),
                        //         child: Center(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //               CrossAxisAlignment
                        //                   .center,
                        //               mainAxisAlignment:
                        //               MainAxisAlignment
                        //                   .center,
                        //               children: [
                        //                 Text(
                        //                   "Get started",
                        //                   textAlign: TextAlign
                        //                       .center,
                        //                   style: TextStyle(
                        //                       fontSize: 18,
                        //                       fontWeight:
                        //                       FontWeight
                        //                           .bold,
                        //                       color: Colors
                        //                           .white),
                        //                 ),
                        //               ],
                        //             )),
                        //       ),
                        //     )
                        //   ),
                        // ) : SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12),
                          child: GestureDetector(
                              onTap: () {
                                AdHelper.showInterstitialGetStartAd(onComplete: () async {
                                  fb.logEvent(name: "interstitial_ad");
                                  /// Khi chạy xong progress thì chuyển trang
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GuidePage()),
                                  );
                                });
                              },
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 3/4,
                                  decoration: BoxDecoration(
                                      color: HexColor.fromHex("#FF9700"),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          12)),
                                  child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            "Get started",
                                            textAlign: TextAlign
                                                .center,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                color: Colors
                                                    .white),
                                          ),
                                        ],
                                      )),
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 12,),
                        Center(
                          child: Text(
                            "By tapping Get started, you agree with our Privacy Policy",
                            textAlign: TextAlign
                                .center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight:
                                FontWeight.bold,
                                color: Colors
                                    .white),
                          ),),
                      ],
                    ),
                  ),
                ),
                bottom: MediaQuery.of(context).padding.bottom + 80,
              ),
              Positioned(
                child:
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
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bannerController.bannerAd = AdHelper.loadBannerHomeAd(
      adController: _bannerController,
      onLoaded: () {
        print("Banner loaded successfully!");
        // update UI hoặc logic khác khi banner load xong
        setState(() {});
      },
    );
  }
}
