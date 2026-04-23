//
import 'package:emotes/luckyspin/diamond_wheel.dart';
import 'package:emotes/luckyspin/dress_wheel.dart';
import 'package:emotes/luckyspin/gun_wheel.dart';
import 'package:emotes/luckyspin/pet_wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../share/utils/message_utils.dart';
import '../guide/guide_page.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../share/widgets/animation_widget.dart';

class LuckySpinPage extends StatefulWidget {
  @override
  State<LuckySpinPage> createState() => _LuckySpinPageState();
}

class _LuckySpinPageState extends State<LuckySpinPage> {
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showRatingDialog();
    // });
  }

  final InAppReview _inAppReview = InAppReview.instance;

  void _showRatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Người dùng phải bấm mới tắt
      builder: (context) => CustomRatingDialog(), // Đây là dialog đánh giá đã viết ở trên
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1435), // nền tối tím
        appBar: AppBar(
          backgroundColor: const Color(0xFF3A2768),
          title: const Text('LUCKY SPIN WHEEL', style: TextStyle(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                child: AnimatedTapWrapper(
                                  onTap: () {
                                    AdHelper.showRewardedAd(onComplete: () async {
                                      /// Khi chạy xong progress thì chuyển trang
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GunWheelPage(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Image(
                                      image: AssetImage('assets/home/lucky1.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),),

                              Expanded(child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                child: AnimatedTapWrapper(
                                  onTap: () {
                                    AdHelper.showRewardedAd(onComplete: () async {
                                      /// Khi chạy xong progress thì chuyển trang
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DressWheelPage(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Image(
                                      image: AssetImage('assets/home/lucky2.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),),
                              Expanded(child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                child: AnimatedTapWrapper(
                                  onTap: () {
                                    AdHelper.showRewardedAd(onComplete: () async {
                                      /// Khi chạy xong progress thì chuyển trang
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PetWheelPage(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Image(
                                      image: AssetImage('assets/home/lucky3.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),),
                              Expanded(child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                child: AnimatedTapWrapper(
                                  onTap: () {
                                    AdHelper.showRewardedAd(onComplete: () async {
                                      /// Khi chạy xong progress thì chuyển trang
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DiamondWheelPage(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Image(
                                      image: AssetImage('assets/home/lucky4.png'),
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),),
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).viewPadding.bottom + 24,
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
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      } else {
        await _inAppReview.openStoreListing(appStoreId: 'com.fps.quick');
      }
      MessageUtils.showSuccessMessage(context, "Thank you for supporting us! 🎉");
    } else {
      MessageUtils.showSuccessMessage(context, "Thank you for supporting us! 🎉");
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flash_on, color: Colors.orangeAccent, size: 60),
            SizedBox(height: 16),
            Text(
              'Rate 5⭐ to Unlock 240 FPS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Enjoy ultra-smooth 240 FPS?\nGive us a 5-star review to unlock it! 🚀',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < _selectedRating ? Colors.amber : Colors.grey,
                    size: 36,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRating,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 55), // full width, cao 55
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: Text(
                'Unlock Now',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Maybe Later',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}