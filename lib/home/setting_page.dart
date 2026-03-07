import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final BannerAdController _bannerController = BannerAdController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bannerController.bannerAd = AdHelper.loadBannerLuckyPetAd(
      adController: _bannerController,
      onLoaded: () {
        print("Banner loaded successfully!");
        // update UI hoặc logic khác khi banner load xong
        setState(() {});
      },
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Người dùng phải bấm mới tắt
      builder: (context) => CustomRatingDialog(), // Đây là dialog đánh giá đã viết ở trên
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "SETTINGS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingItem(Icons.language, "LANGUAGE"),
          _buildSettingItem(Icons.star_border, "RATE US"),
          _buildSettingItem(Icons.feedback_outlined, "GUIDE"),
          _buildSettingItem(Icons.share, "SHARE APP"),
          _buildSettingItem(Icons.privacy_tip_outlined, "PRIVACY POLICY"),
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
        ],
      ),
    );
  }


  Widget _buildSettingItem(IconData icon, String title) {
    return Card(
      color: const Color(0xFF262B31),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            letterSpacing: 1.2,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: () {
          // TODO: xử lý khi
          if ( title == "LANGUAGE") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LanguageScreen(
                  onSelect: (lang) {
                    print("Selected language: $lang");
                    // TODO: đổi ngôn ngữ ở đây
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          } else if ( title == "GUIDE") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GuideScreen()),
            );
          } else if ( title == "PRIVACY POLICY") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PolicyScreen()),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showRatingDialog();
            });
          }

        },
      ),
    );
  }
}

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Guide",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "How to Use Evalore Emotes View",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent,
              ),
            ),
            const SizedBox(height: 16),

            // 1. Browse Emotes
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.emoji_emotions,
                        size: 36, color: Colors.yellowAccent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Browse Emotes",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Explore the full collection of emotes available in the app. Scroll through categories or search by name.",
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 2. Preview Emotes
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.play_circle_fill,
                        size: 36, color: Colors.lightBlueAccent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Preview Emotes",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Tap on an emote to preview its animation in full screen. You can replay it as many times as you want.",
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Favorites
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.favorite,
                        size: 36, color: Colors.redAccent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Save Your Favorites",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Mark emotes as favorite to quickly access them later in your personal collection.",
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Footer
            const Text(
              "Tip: Keep your favorite emotes handy by adding them to your Favorites list.",
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "App Policy",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              const Text(
                "1. Evalore Emotes View is designed for entertainment purposes, allowing users to view and explore in-game emotes.\n\n"
                    "2. This app does not collect, store, or share any personal data from your device.\n\n"
                    "3. All emote previews and resources are displayed for reference only and belong to their respective owners.\n\n"
                    "4. Users are not allowed to redistribute or use the emote content for commercial purposes.\n\n"
                    "5. The app works offline for most features, but certain resources may require updates.\n\n"
                    "6. By using this app, you agree to comply with these terms and respect the intellectual property rights of the original game developers.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "I Understand",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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

class LanguageScreen extends StatelessWidget {
  final void Function(String) onSelect;

  const LanguageScreen({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLangButton(
              "Tiếng Việt",
              "assets/language/vietnam.png",
                  () => onSelect("vi"),
            ),
            const SizedBox(height: 20),
            _buildLangButton(
              "English",
              "assets/language/usa.png",
                  () => onSelect("en"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangButton(String text, String asset, VoidCallback onTap) {
    return InkWell(
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
    );
  }
}
