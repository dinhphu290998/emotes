import 'package:emotes/json/json.dart';
import 'package:emotes/skins/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';

class GunsPage extends StatefulWidget {
  @override
  State<GunsPage> createState() => _GunsPageState();
}
class _GunsPageState extends State<GunsPage> {

  final _adController = NativeAdController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('====================================');
    _adController.ad = AdHelper.loadNativeGunAd(adController: _adController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1435), // nền tối tím
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A2768),
        title: const Text('Guns', style: TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(child: GridView.builder(
              itemCount: guns.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final gun = guns[index];
                return GestureDetector(
                  onTap: () {
                    AdHelper.showInterstitialSelectAd(onComplete: () async {
                      /// Khi chạy xong progress thì chuyển trang
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(data: gun),
                        ),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF23203F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              gun['image']!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, color: Colors.red),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A2E59),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            gun['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),),
            _adController.ad != null && _adController.adLoaded.isTrue ? SizedBox(
                height: 300 + MediaQuery.of(context).padding.bottom, child: AdWidget(ad: _adController.ad!)) : Container()
          ],
        )
      ),
    );
  }
}
