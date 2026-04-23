import 'package:emotes/json/json.dart';
import 'package:flutter/material.dart';

import '../helpers/ad_helper.dart';
import 'detail_page.dart';

class BooyahPage extends StatefulWidget {
  @override
  State<BooyahPage> createState() => _BooyahPageState();
}
class _BooyahPageState extends State<BooyahPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1435), // nền tối tím
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A2768),
        title: const Text('Booyah Passes', style: TextStyle(
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
        child: GridView.builder(
          itemCount: booyah_or_passes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final passes = booyah_or_passes[index];
            return GestureDetector(
              onTap: () {
                AdHelper.showRewardedAd(onComplete: () async {
                  /// Khi chạy xong progress thì chuyển trang
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(data: passes),
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
                          passes['image']!,
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
                        passes['name']!,
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
        ),
      ),
    );
  }
}
