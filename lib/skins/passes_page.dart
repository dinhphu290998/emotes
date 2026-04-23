//
import 'package:emotes/luckyspin/luckyspin_page.dart';
import 'package:emotes/skins/booyah_page.dart';
import 'package:emotes/skins/dress_page.dart';
import 'package:emotes/skins/guns_page.dart';
import 'package:emotes/skins/pets_page.dart';
import 'package:emotes/skins/skins_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../share/utils/message_utils.dart';
import '../controllers/native_ad_controller.dart';
import '../guide/guide_page.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../share/widgets/animation_widget.dart';

class PassesPage extends StatefulWidget {
  @override
  State<PassesPage> createState() => _PassesPageState();
}

class _PassesPageState extends State<PassesPage> {
  final _adController = NativeAdController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('====================================');
    _adController.ad = AdHelper.loadNativeEmotesAd(adController: _adController);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1435), // nền tối tím
        appBar: AppBar(
          backgroundColor: const Color(0xFF3A2768),
          title: const Text('Passes', style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height / 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: AnimatedTapWrapper(
                                      onTap: () {
                                        AdHelper.showRewardedAd(onComplete: () async {
                                          /// Khi chạy xong progress thì chuyển trang
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BooyahPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home7.png',
                                          ),
                                          height:
                                              MediaQuery.of(context).size.height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height / 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: AnimatedTapWrapper(
                                      onTap: () {
                                        AdHelper.showRewardedAd(onComplete: () async {
                                          /// Khi chạy xong progress thì chuyển trang
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SkinsPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home8.png',
                                          ),
                                          height:
                                          MediaQuery.of(context).size.height,
                                          width:
                                          MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _adController.ad != null && _adController.adLoaded.isTrue ? SizedBox(
                                    height: 300 + MediaQuery.of(context).padding.bottom, child: AdWidget(ad: _adController.ad!)) : Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 12),
                      //   child: Container(
                      //     height: 350, // tăng chiều cao Native Ad lên
                      //     color: Colors.transparent,
                      //     child:
                      //     (AdManager.instance.isNativeAdPassesReady && AdManager.instance.nativeAdPasses != null)
                      //         ? Container(height: 350, color: Colors.transparent,child: AdWidget(ad: AdManager.instance.nativeAdPasses!))
                      //         : SizedBox.shrink(),
                      //   ),
                      // ),
                      Container(
                        height: MediaQuery.of(context).viewPadding.bottom + 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}