import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  static final _config = FirebaseRemoteConfig.instance;

  static const _defaultValues = {
    "interstitial_ad": "ca-app-pub-2517476362171621/9543253375", //
    "interstitial_start_ad": "ca-app-pub-2517476362171621/9543253375", //
    "interstitial_get_start_ad": "ca-app-pub-2517476362171621/9543253375", //
    "interstitial_select": "ca-app-pub-2517476362171621/9543253375", //

    "native_ad": "ca-app-pub-1965570099044440/6458596822", //
    "native_language_ad": "ca-app-pub-1965570099044440/5380338938", //
    "native_info_ad": "ca-app-pub-1965570099044440/6769442225", //
    "native_page_1": "ca-app-pub-1965570099044440/5177304746", //
    "native_page_2": "ca-app-pub-1965570099044440/8653369539", //
    "native_page_3": "ca-app-pub-1965570099044440/2443184402", //
    "native_select": "ca-app-pub-1965570099044440/9395605568", //

    "native_gun": "ca-app-pub-1965570099044440/6027206197",
    "native_character": "ca-app-pub-1965570099044440/6382429416",
    "native_pet": "ca-app-pub-1965570099044440/6769442225",
    "native_emotes": "ca-app-pub-1965570099044440/9084760169",

    "native_lucky_gun": "ca-app-pub-1965570099044440/1708687234",
    "native_lucky_character": "ca-app-pub-1965570099044440/7680508720",

    "rewarded_ad": "ca-app-pub-1965570099044440/9380603201", //

    "banner_ad": "ca-app-pub-1965570099044440/2212559623", //
    "banner_home_ad": "ca-app-pub-1965570099044440/4877776054", //
    "banner_detail_ad": "ca-app-pub-1965570099044440/7695511082",
    "banner_lucky_pet_ad": "ca-app-pub-1965570099044440/8893188476",
    "banner_lucky_diamond_ad": "ca-app-pub-1965570099044440/2919136630",

    "show_ads": true,
    "show_ads_before": true
  };

  static Future<void> initConfig() async {
    await _config.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 30)));

    await _config.setDefaults(_defaultValues);
    await _config.fetchAndActivate();
    log('Remote Config Data: ${_config.getBool('show_ads')}');
    log('Remote Config Data: ${_config.getBool('show_ads_before')}');

    _config.onConfigUpdated.listen((event) async {
      await _config.activate();
      log('Updated: ${_config.getBool('show_ads')}');
      log('Updated: ${_config.getBool('show_ads_before')}');
    });
  }

  static bool get _showAd => _config.getBool('show_ads');
  static bool get _showAdBefore => _config.getBool('show_ads_before');

  //ad ids
  static String get nativeAd => _config.getString('native_ad');
  static String get nativeLanguageAd => _config.getString('native_language_ad');
  static String get nativeInfoAd => _config.getString('native_info_ad');
  static String get nativePage1Ad => _config.getString('native_page_1');
  static String get nativePage2Ad => _config.getString('native_page_2');
  static String get nativePage3Ad => _config.getString('native_page_3');
  static String get nativeSelectAd => _config.getString('native_select');

  static String get nativeGunAd => _config.getString('native_gun');
  static String get nativeCharacterAd => _config.getString('native_character');
  static String get nativePetAd => _config.getString('native_pet');
  static String get nativeEmotesAd => _config.getString('native_emotes');
  static String get nativeLuckyGunAd => _config.getString('native_lucky_gun');
  static String get nativeLuckyCharacterAd => _config.getString('native_lucky_character');

  static String get interstitialAd => _config.getString('interstitial_ad');
  static String get interstitialStartAd => _config.getString('interstitial_start_ad');
  static String get interstitialGetStartAd => _config.getString('interstitial_get_start_ad');
  static String get interstitialSelectAd => _config.getString('interstitial_select');

  static String get rewardedAd => _config.getString('rewarded_ad');

  static String get bannerAd => _config.getString('banner_ad');
  static String get bannerHomeAd => _config.getString('banner_home_ad');
  static String get bannerDetailAd => _config.getString('banner_detail_ad');
  static String get bannerLuckyPetAd => _config.getString('banner_lucky_pet_ad');
  static String get bannerLuckyDiamondAd => _config.getString('banner_lucky_diamond_ad');

  static bool get hideAds => !_showAd;
  static bool get hideAdsBefore => !_showAdBefore;
}
