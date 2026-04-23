//
import 'package:emotes/home/setting_page.dart';
import 'package:emotes/luckyspin/luckyspin_page.dart';
import 'package:emotes/skins/dress_page.dart';
import 'package:emotes/skins/guns_page.dart';
import 'package:emotes/skins/passes_page.dart';
import 'package:emotes/skins/pets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../share/utils/message_utils.dart';
import '../controllers/native_ad_controller.dart';
import '../guide/guide_page.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../share/widgets/animation_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _adController = NativeAdController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('====================================');
    // AdManager.instance.loadNativeAdNativeHome(
    //   onAdLoaded: () {
    //     setState(() {}); // Phải gọi để update màn hình
    //   },
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRatingDialog();
    });

    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

  }

  final InAppReview _inAppReview = InAppReview.instance;

  void _showRatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Người dùng phải bấm mới tắt
      builder:
          (context) =>
              CustomRatingDialog(), // Đây là dialog đánh giá đã viết ở trên
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1435),
        appBar: AppBar(
          backgroundColor: Colors.black, // nền tối
          elevation: 0, // không đổ bóng
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // mở drawer hoặc menu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          title: Text("EMOTES VIEWER", style: TextStyle(color: Colors.white),),
        ),
        // nền tối tím
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
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                                              builder: (context) => GunsPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home4.png',
                                          ),
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                                              builder:
                                                  (context) => LuckySpinPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home3.png',
                                          ),
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _adController.ad != null && _adController.adLoaded.isTrue ? SizedBox(
                                    height: 120, child: AdWidget(ad: _adController.ad!)) : Container(),
                                Container(
                                  height:
                                  MediaQuery.of(context).size.height / 4,
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
                                              builder: (context) => DressPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home6.png',
                                          ),
                                          height:
                                          MediaQuery.of(
                                            context,
                                          ).size.height,
                                          width:
                                          MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                                              builder: (context) => PetsPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home5.png',
                                          ),
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                                              builder: (context) => PassesPage(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/home/home2.png',
                                          ),
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   height: MediaQuery.of(context).size.height / 4,
                                //   child: Padding(
                                //     padding: EdgeInsets.symmetric(
                                //       horizontal: 20,
                                //       vertical: 12,
                                //     ),
                                //     child: AnimatedTapWrapper(
                                //       onTap: () {
                                //         Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //             builder: (context) => LuckySpinPage(),
                                //           ),
                                //         );
                                //         // EasyLoading.show();
                                //         // AdManager.instance.loadInterstitialAdHome(
                                //         //   onAdDismissed: () {
                                //         //     EasyLoading.dismiss();
                                //         //     Navigator.push(
                                //         //       context,
                                //         //       MaterialPageRoute(builder: (context) => LocationPage()),
                                //         //     );
                                //         //   },
                                //         // );
                                //       },
                                //       child: Container(
                                //         clipBehavior: Clip.antiAlias,
                                //         decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(20),
                                //         ),
                                //         child: Image(
                                //           image: AssetImage(
                                //             'assets/home/home1.png',
                                //           ),
                                //           height:
                                //               MediaQuery.of(context).size.height,
                                //           width:
                                //               MediaQuery.of(context).size.width,
                                //           fit: BoxFit.cover,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                      //     (AdManager.instance.isNativeAdHomeReady && AdManager.instance.nativeAdHome != null)
                      //         ? Container(height: 350, color: Colors.transparent,child: AdWidget(ad: AdManager.instance.nativeAdHome!))
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

class CustomRatingDialog extends StatefulWidget {
  @override
  _CustomRatingDialogState createState() => _CustomRatingDialogState();
}

class _CustomRatingDialogState extends State<CustomRatingDialog> {
  int _selectedRating = 5; // Mặc định 5 sao
  final InAppReview _inAppReview = InAppReview.instance;

  void _submitRating() async {
    if (_selectedRating >= 4) {
      try {
        if (await _inAppReview.isAvailable()) {
          await _inAppReview.requestReview();
        } else {
          await _inAppReview.openStoreListing();
        }
      } catch (e) {
        // fallback nếu openStoreListing lỗi
        await launchUrl(
          Uri.parse("https://play.google.com/store/apps/details?id=com.ndp.emotes"),
          mode: LaunchMode.externalApplication,
        );
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Thank you for supporting us! 🎉")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Thank you for supporting us! 🎉")));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors
          .transparent, // ❌ bỏ nền mặc định, để chỉ thấy khung neon
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.cyanAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "GIVE US A 5-STAR RATING TO RECEIVE A GIFT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade400,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.greenAccent,
                      elevation: 10,
                    ),
                    onPressed: _submitRating,
                    child: const Text(
                      "RATE US",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}