import 'dart:async';
import 'dart:io';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../home/home_page.dart';
import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../share/utils/rest_api_service.dart';
import '../share/widgets/animation_widget.dart';

class GuidePage extends StatefulWidget {
  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  final _ad1Controller = NativeAdController();
  final _ad2Controller = NativeAdController();
  final _ad3Controller = NativeAdController();

  PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 1,
    keepPage: true,
  );

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: controller,
                      onPageChanged: (ind) {
                        setState(() {
                          index = ind;
                          print("index ${index}");
                        });
                      },
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('assets/background/step1.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "EXPLORE ALL EMOTES",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Explore a wide collection of emotes \n categorized by themes like FFire, PBG",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: GestureDetector(
                                          onTap: () {
                                            controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeIn,
                                            );
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
                                                        "Next",
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
                                    _ad1Controller.ad != null && _ad1Controller.adLoaded.isTrue ? SizedBox(
                                        height: 350, child: AdWidget(ad: _ad1Controller.ad!)) : Container()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('assets/background/step2.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "GUN SKINS",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Explore our new collection of Gun Skins \n organized by category",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: GestureDetector(
                                          onTap: () {
                                            controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeIn,
                                            );
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
                                                        "Next",
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
                                    _ad2Controller.ad != null && _ad2Controller.adLoaded.isTrue ? SizedBox(
                                        height: 350, child: AdWidget(ad: _ad2Controller.ad!)) : Container()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('assets/background/step3.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Spin for Epic Rewards",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Try your luck and unlock exclusive \n emotes, skins, and more",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: GestureDetector(
                                          onTap: () {
                                            AdHelper.showInterstitialGetStartAd(onComplete: () async {
                                              fb.logEvent(name: "interstitial_ad");
                                              /// Khi chạy xong progress thì chuyển trang
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => HomePage()),
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
                                                        "Get Started",
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
                                    _ad3Controller.ad != null && _ad3Controller.adLoaded.isTrue ? SizedBox(
                                        height: 350, child: AdWidget(ad: _ad3Controller.ad!)) : Container()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   child:
                    //       index != 4
                    //           ? GestureDetector(
                    //             onTap: () {
                    //               controller.nextPage(
                    //                 duration: Duration(milliseconds: 500),
                    //                 curve: Curves.easeIn,
                    //               );
                    //             },
                    //             child: Container(
                    //               height: 60,
                    //               width: 60,
                    //               child: Center(
                    //                 child: Icon(
                    //                   Icons.keyboard_double_arrow_right,
                    //                   size: 24,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(30),
                    //                 color: HexColor.fromHex("#FF9700"),
                    //               ),
                    //             ),
                    //           )
                    //           : Container(),
                    //   bottom: MediaQuery.of(context).viewPadding.bottom + 32,
                    //   right: 24,
                    // ),
                    Positioned(
                      child:
                          index != 2
                              ? GestureDetector(
                                child: Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color:
                                        index == 0
                                            ? HexColor.fromHex("#FF9700") : Colors.grey,
                                  ),
                                ),
                              )
                              : Container(),
                      bottom: MediaQuery.of(context).viewPadding.bottom + 86,
                      right: 28,
                    ),
                    Positioned(
                      child:
                          index != 2
                              ? GestureDetector(
                                child: Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color:
                                        index == 1
                                            ? HexColor.fromHex("#FF9700") : Colors.grey,
                                  ),
                                ),
                              )
                              : Container(),
                      bottom: MediaQuery.of(context).viewPadding.bottom + 86,
                      right: 20,
                    ),
                    Positioned(
                      child:
                          index != 2
                              ? GestureDetector(
                                child: Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color:
                                        index == 2
                                            ? HexColor.fromHex("#FF9700") : Colors.grey,
                                  ),
                                ),
                              )
                              : Container(),
                      bottom: MediaQuery.of(context).viewPadding.bottom + 86,
                      right: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final fb = FacebookAppEvents();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ad1Controller.ad = AdHelper.loadNativePage1Ad(adController: _ad1Controller);
    _ad2Controller.ad = AdHelper.loadNativePage2Ad(adController: _ad2Controller);
    _ad3Controller.ad = AdHelper.loadNativePage3Ad(adController: _ad3Controller);

  }
}
