import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../home/home_page.dart';
import '../../splash/onboarding.dart';

import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import '../share/extensions/color_extensions.dart';
import '../share/utils/local_storage.dart';
import '../share/widgets/animation_widget.dart';

class LanguagePage extends StatefulWidget {
  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {

    _adController.ad = AdHelper.loadNativeLanguageAd(adController: _adController);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            "LANGUAGE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                _buildLangButton(
                  "English",
                  "assets/language/usa.png",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                _buildLangButton(
                  "Tiếng Việt",
                  "assets/language/vietnam.png",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingPage(),
                      ),
                    );
                  },
                ),

                Expanded(child: Container()),

                _adController.ad != null && _adController.adLoaded.isTrue ? SizedBox(
                    height: 300 + MediaQuery.of(context).padding.bottom, child: AdWidget(ad: _adController.ad!)) : Container(),

                const SizedBox(height: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<bool> list = [false, true];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // EasyLoading.dismiss();
    // LocalStorageService.setStringValue("ENGLISH", "LANGUAGE");
    // AdManager.instance.loadNativeAdLanguage(
    //   AdManager.instance.Native_Language_1,
    //   onAdLoaded: () {
    //     setState(() {}); // Phải gọi để update màn hình
    //   },
    // );
  }


  Widget _buildLangButton(String text, String asset, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.cyanAccent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
              )
            ],
          ),
          child: Row(
            children: [
              Image.asset(asset, width: 45, height: 45),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
