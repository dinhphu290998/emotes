import 'dart:async';
import 'dart:math';
import 'package:emotes/json/json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../skins/detail_page.dart';

class PetWheelPage extends StatefulWidget {
  @override
  _PetWheelPageState createState() => _PetWheelPageState();
}

class _PetWheelPageState extends State<PetWheelPage> {
  final List<Map<String, String>> rewards = [];
  final StreamController<int> controller = StreamController<int>();
  Random random = Random();
  final _adSelectController = NativeAdController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    while (rewards.length < 8) {
      rewards.add(pets[random.nextInt(pets.length)]);
    }
    _adSelectController.ad = AdHelper.loadNativeSelectAd(adController: _adSelectController);

  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void spinWheel() {
    final randomIndex = Random().nextInt(rewards.length);
    print("randomIndex: ${randomIndex}");
    startTimer(rewards[randomIndex]);
    controller.add(randomIndex);
  }

  late Timer _timer;
  void startTimer(Map<String, String> reward) {
    const oneSec = const Duration(milliseconds: 5500);
    _timer = new Timer.periodic(oneSec, (Timer timer) async {
      _showDialog(reward: reward);
      timer.cancel();
    });
  }

  void _showDialog({required Map<String, String> reward}) {
    AdHelper.showInterstitialAd(onComplete: () async {
      showDialog(
        context: context,
        barrierDismissible: false, // Người dùng phải bấm mới tắt
        builder:
            (context) =>
            CustomDialog(reward: reward,), // Đây là dialog đánh giá đã viết ở trên
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1435), // nền tối tím
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A2768),
        title: const Text('PETS SPIN WHEEL', style: TextStyle(
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.rotate(
                                angle: 90 * 3.1415926535 / 180, // xoay 90 độ
                                child: Image.network(
                                  reward['image']!,
                                  fit: BoxFit.contain,
                                  height: 120,
                                  width: 120,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, color: Colors.red),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                            ],
                          ),
                          style: FortuneItemStyle(
                            color: Colors.green,
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
                        border: Border.all(color: Colors.yellow, width: 5)
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icon/diamond.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 12, vertical: 24),
              child: GestureDetector(
                  onTap: spinWheel,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 3/4,
                      decoration: BoxDecoration(
                          color: Colors.green,
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
                                "Get Spin",
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
            _adSelectController.ad != null && _adSelectController.adLoaded.isTrue ? SizedBox(
                height: 350, child: AdWidget(ad: _adSelectController.ad!)) : Container(height: 24,)
          ],
        ),
      ),
    );
  }
}


class CustomDialog extends StatefulWidget {

  final Map<String, String> reward;
  const CustomDialog({super.key, required this.reward});

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              widget.reward['image']!,
              fit: BoxFit.contain,
              height: 200,
              width: 200,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, color: Colors.red),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                    child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 16),
            Text(
              widget.reward["name"] ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Amazing! You have ${widget.reward["name"]} to your collection',
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
