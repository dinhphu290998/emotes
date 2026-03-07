import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../skins/detail_page.dart';

class DiamondWheelPage extends StatefulWidget {
  @override
  _DiamondWheelPageState createState() => _DiamondWheelPageState();
}

class _DiamondWheelPageState extends State<DiamondWheelPage> {
  final List<String> rewards = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',
    '6000',
    '7000',
    '8000',
  ];
  final StreamController<int> controller = StreamController<int>();
  final _adController = NativeAdController();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void spinWheel() {
    final randomIndex = Random().nextInt(rewards.length);
    print("randomIndex: ${randomIndex}");
    startTimer(randomIndex);
    controller.add(randomIndex);
  }

  late Timer _timer;
  void startTimer(int randomIndex) {
    const oneSec = const Duration(milliseconds: 5500);
    _timer = new Timer.periodic(oneSec, (Timer timer) async {
      _showDialog(randomIndex: randomIndex);
      timer.cancel();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adController.ad = AdHelper.loadNativeInfoAd(adController: _adController);

  }

  void _showDialog({required int randomIndex}) {
    AdHelper.showInterstitialAd(onComplete: () async {
      /// Khi chạy xong progress thì chuyển trang
      showDialog(
        context: context,
        barrierDismissible: false, // Người dùng phải bấm mới tắt
        builder:
            (context) =>
            CustomDialog(randomIndex: randomIndex, reward: {
              "name": "+1000 Diamond",
              "image": "https://cdn-icons-png.flaticon.com/512/6220/6220803.png",
            },), // Đây là dialog đánh giá đã viết ở trên
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1435), // nền tối tím
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A2768),
        title: const Text(
          'DIAMOND',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: Stack(
                children: [
                  FortuneWheel(
                    selected: controller.stream,
                    items: [
                      for (var reward in rewards)
                        FortuneItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 60),
                              Expanded(
                                child: Text(
                                  reward,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/icon/diamond.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(width: 30),
                            ],
                          ),
                          style: FortuneItemStyle(
                            color: Colors.red,
                            borderColor: Colors.yellow,
                            borderWidth: 2,
                          ),
                        ),
                    ],
                    indicators: <FortuneIndicator>[
                      FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: TriangleIndicator(color: Colors.yellow),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        border: Border.all(color: Colors.yellow, width: 5),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icon/diamond.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: GestureDetector(
                onTap: spinWheel,
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get Spin",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _adController.ad != null && _adController.adLoaded.isTrue ? SizedBox(
                height: 300 + MediaQuery.of(context).padding.bottom, child: AdWidget(ad: _adController.ad!)) : Container(height: 24,)
            /// 🔥 Quan trọng: Dùng ValueListenableBuilder để lắng nghe sự kiện load
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {

  final int randomIndex;
  final Map<String, String> reward;
  const CustomDialog({super.key, required this.randomIndex, required this.reward});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  void _submitRating() async {
    AdHelper.showRewardedAd(onComplete: () {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(data: widget.reward),
        ),
      );
    });
  }

  final List<String> rewards = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',
    '6000',
    '7000',
    '8000',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(color: Colors.yellow, width: 5),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icon/diamond.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              rewards[widget.randomIndex],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Amazing! You have added ${rewards[widget.randomIndex]} \nDiamonds to your collection',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
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
                'REWARD',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Maybe Later', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
