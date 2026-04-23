import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';
import 'config.dart';
import 'my_dialogs.dart';

class AdHelper {
  // for initializing ads sdk
  static Future<void> initAds() async {
    await MobileAds.instance.initialize();
  }

  static InterstitialAd? _interstitialAd;
  static bool _interstitialAdLoaded = false;

  static InterstitialAd? _interstitialStartAd;
  static bool _interstitialStartAdLoaded = false;

  static InterstitialAd? _interstitialGetStartAd;
  static bool _interstitialGetStartAdLoaded = false;

  static InterstitialAd? _interstitialSelectAd;
  static bool _interstitialSelectAdLoaded = false;

  static NativeAd? _nativeAd;
  static bool _nativeAdLoaded = false;

  static NativeAd? _nativeLanguageAd;
  static bool _nativeLanguageAdLoaded = false;

  static NativeAd? _nativePage1Ad;
  static bool _nativePage1AdLoaded = false;

  static NativeAd? _nativePage2Ad;
  static bool _nativePage2AdLoaded = false;

  static NativeAd? _nativePage3Ad;
  static bool _nativePage3AdLoaded = false;

  static NativeAd? _nativeInfoAd;
  static bool _nativeInfoAdLoaded = false;

  static NativeAd? _nativeSelectAd;
  static bool _nativeSelectAdLoaded = false;

  static NativeAd? _nativeGunAd;
  static bool _nativeGunAdLoaded = false;

  static NativeAd? _nativeCharacterAd;
  static bool _nativeCharacterAdLoaded = false;

  static NativeAd? _nativePetAd;
  static bool _nativePetAdLoaded = false;

  static NativeAd? _nativeEmotesAd;
  static bool _nativeEmotesAdLoaded = false;

  static NativeAd? _nativeLuckyGunAd;
  static bool _nativeLuckyGunAdLoaded = false;

  static NativeAd? _nativeLuckyCharacterAd;
  static bool _nativeLuckyCharacterAdLoaded = false;

  static BannerAd? _bannerAd;
  static bool _bannerAdLoaded = false;

  static BannerAd? _bannerHomeAd;
  static bool _bannerHomeAdLoaded = false;

  static BannerAd? _bannerDetailAd;
  static bool _bannerDetailAdLoaded = false;

  static BannerAd? _bannerLuckyPetAd;
  static bool _bannerLuckyPetAdLoaded = false;

  //*****************Interstitial Ad******************

  static void precacheInterstitialAd() {
    log('Precache Interstitial Ad - Id: ${Config.interstitialAd}');

    if (Config.hideAdsBefore) return;

    InterstitialAd.load(
      adUnitId: Config.interstitialAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            _resetInterstitialAd();
            precacheInterstitialAd();
          });
          _interstitialAd = ad;
          _interstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetInterstitialAd();
          log('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _interstitialAdLoaded = false;
  }

  static void showInterstitialAd({required VoidCallback onComplete}) {
    log('Interstitial Ad Id: ${Config.interstitialAd}');

    if (Config.hideAdsBefore) {
      onComplete();
      return;
    }

    if (_interstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd?.show();
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    InterstitialAd.load(
      adUnitId: Config.interstitialAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            onComplete();
            _resetInterstitialAd();
            precacheInterstitialAd();
          });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an showInterstitialAd ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  //*****************Interstitial Start Ad******************

  static void precacheInterstitialStartAd() {
    log('Precache Interstitial Start Ad - Id: ${Config.interstitialStartAd}');

    if (Config.hideAdsBefore) return;

    InterstitialAd.load(
      adUnitId: Config.interstitialStartAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                _resetInterstitialStartAd();
                precacheInterstitialStartAd();
              });
          _interstitialStartAd = ad;
          _interstitialStartAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetInterstitialStartAd();
          log('Failed to load an precacheInterstitialStartAd start ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetInterstitialStartAd() {
    _interstitialStartAd?.dispose();
    _interstitialStartAd = null;
    _interstitialStartAdLoaded = false;
  }

  static void showInterstitialStartAd({required VoidCallback onComplete}) {
    log('Interstitial Start Ad Id: ${Config.interstitialStartAd}');

    if (Config.hideAdsBefore) {
      onComplete();
      return;
    }

    if (_interstitialStartAdLoaded && _interstitialStartAd != null) {
      _interstitialStartAd?.show();
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    InterstitialAd.load(
      adUnitId: Config.interstitialStartAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                onComplete();
                _resetInterstitialStartAd();
                precacheInterstitialStartAd();
              });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an showInterstitialStartAd ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  //*****************Interstitial Get Start Ad******************

  static void precacheInterstitialGetStartAd() {
    log('Precache Interstitial Get Start Ad - Id: ${Config.interstitialGetStartAd}');

    if (Config.hideAds) return;

    InterstitialAd.load(
      adUnitId: Config.interstitialGetStartAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                _resetInterstitialGetStartAd();
                precacheInterstitialGetStartAd();
              });
          _interstitialGetStartAd = ad;
          _interstitialGetStartAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetInterstitialGetStartAd();
          log('Failed to load an precacheInterstitialGetStartAd get start ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetInterstitialGetStartAd() {
    _interstitialGetStartAd?.dispose();
    _interstitialGetStartAd = null;
    _interstitialGetStartAdLoaded = false;
  }

  static void showInterstitialGetStartAd({required VoidCallback onComplete}) {
    log('Interstitial Get Start Ad Id: ${Config.interstitialGetStartAd}');

    if (Config.hideAds) {
      onComplete();
      return;
    }

    if (_interstitialGetStartAdLoaded && _interstitialGetStartAd != null) {
      _interstitialGetStartAd?.show();
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    InterstitialAd.load(
      adUnitId: Config.interstitialGetStartAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                onComplete();
                _resetInterstitialGetStartAd();
                precacheInterstitialGetStartAd();
              });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an showInterstitialGetStartAd ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  //*****************Interstitial Get Start Ad******************

  static void precacheInterstitialSelectAd() {
    log('Precache Interstitial Select Ad - Id: ${Config.interstitialSelectAd}');

    if (Config.hideAdsBefore) return;

    InterstitialAd.load(
      adUnitId: Config.interstitialSelectAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                _resetInterstitialSelectAd();
                precacheInterstitialSelectAd();
              });
          _interstitialSelectAd = ad;
          _interstitialSelectAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetInterstitialSelectAd();
          log('Failed to load an precacheInterstitialSelectAd select ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetInterstitialSelectAd() {
    _interstitialSelectAd?.dispose();
    _interstitialSelectAd = null;
    _interstitialSelectAdLoaded = false;
  }

  static void showInterstitialSelectAd({required VoidCallback onComplete}) {
    log('Interstitial Select Ad Id: ${Config.interstitialSelectAd}');

    if (Config.hideAdsBefore) {
      onComplete();
      return;
    }

    if (_interstitialSelectAdLoaded && _interstitialSelectAd != null) {
      _interstitialSelectAd?.show();
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    InterstitialAd.load(
      adUnitId: Config.interstitialSelectAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                onComplete();
                _resetInterstitialSelectAd();
                precacheInterstitialSelectAd();
              });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an showInterstitialSelectAd ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  //*****************Native Ad******************

  static void precacheNativeAd() {
    log('Precache Native Ad - Id: ${Config.nativeAd}');

    if (Config.hideAds) return;

    _nativeAd = NativeAd(
        adUnitId: Config.nativeAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small))
      ..load();
  }

  static void _resetNativeAd() {
    _nativeAd?.dispose();
    _nativeAd = null;
    _nativeAdLoaded = false;
  }

  static NativeAd? loadNativeAd({required NativeAdController adController}) {
    log('Native Ad Id: ${Config.nativeAd}');

    if (Config.hideAds) return null;

    if (_nativeAdLoaded && _nativeAd != null) {
      adController.adLoaded.value = true;
      return _nativeAd;
    }

    return NativeAd(
        adUnitId: Config.nativeAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeAd();
            precacheNativeAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small))
      ..load();
  }

  //*****************Native Language Ad******************

  static void precacheNativeLanguageAd() {
    log('Precache Native Language Ad - Id: ${Config.nativeLanguageAd}');

    if (Config.hideAds) return;

    _nativeLanguageAd = NativeAd(
        adUnitId: Config.nativeLanguageAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeLanguageAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeLanguageAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeLanguageAd() {
    _nativeLanguageAd?.dispose();
    _nativeLanguageAd = null;
    _nativeLanguageAdLoaded = false;
  }

  static NativeAd? loadNativeLanguageAd({required NativeAdController adController}) {
    log('Native Language Ad Id: ${Config.nativeLanguageAd}');

    if (Config.hideAds) return null;

    if (_nativeLanguageAdLoaded && _nativeLanguageAd != null) {
      adController.adLoaded.value = true;
      return _nativeLanguageAd;
    }

    return NativeAd(
        adUnitId: Config.nativeLanguageAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeLanguageAd();
            precacheNativeLanguageAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeLanguageAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Language Page 1 Ad******************

  static void precacheNativePage1Ad() {
    log('Precache Native Page1 Ad - Id: ${Config.nativePage1Ad}');

    if (Config.hideAds) return;

    _nativePage1Ad = NativeAd(
        adUnitId: Config.nativePage1Ad,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativePage1AdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePage1Ad();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativePage1Ad() {
    _nativePage1Ad?.dispose();
    _nativePage1Ad = null;
    _nativePage1AdLoaded = false;
  }

  static NativeAd? loadNativePage1Ad({required NativeAdController adController}) {
    log('Native Page1 Ad Id: ${Config.nativePage1Ad}');

    if (Config.hideAds) return null;

    if (_nativePage1AdLoaded && _nativePage1Ad != null) {
      adController.adLoaded.value = true;
      return _nativePage1Ad;
    }

    return NativeAd(
        adUnitId: Config.nativePage1Ad,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativePage1Ad();
            precacheNativePage1Ad();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePage1Ad();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Page2 Ad******************

  static void precacheNativePage2Ad() {
    log('Precache Native Page2 Ad - Id: ${Config.nativePage2Ad}');

    if (Config.hideAds) return;

    _nativePage2Ad = NativeAd(
        adUnitId: Config.nativePage2Ad,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativePage2AdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePage2Ad();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativePage2Ad() {
    _nativePage2Ad?.dispose();
    _nativePage2Ad = null;
    _nativePage2AdLoaded = false;
  }

  static NativeAd? loadNativePage2Ad({required NativeAdController adController}) {
    log('Native Page2 Ad Id: ${Config.nativePage2Ad}');

    if (Config.hideAds) return null;

    if (_nativePage2AdLoaded && _nativePage2Ad != null) {
      adController.adLoaded.value = true;
      return _nativePage2Ad;
    }

    return NativeAd(
        adUnitId: Config.nativePage2Ad,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativePage2Ad();
            precacheNativePage2Ad();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePage2Ad();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Page3 Ad******************

  static void precacheNativePage3Ad() {
    log('Precache Native Page3 Ad - Id: ${Config.nativePage3Ad}');

    if (Config.hideAds) return;

    _nativePage3Ad = NativeAd(
        adUnitId: Config.nativePage3Ad,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativePage3AdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePage3Ad();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativePage3Ad() {
    _nativePage3Ad?.dispose();
    _nativePage3Ad = null;
    _nativePage3AdLoaded = false;
  }

  static NativeAd? loadNativePage3Ad({required NativeAdController adController}) {
    log('Native Page3 Ad Id: ${Config.nativePage3Ad}');

    if (Config.hideAds) return null;

    if (_nativePage3AdLoaded && _nativePage3Ad != null) {
      adController.adLoaded.value = true;
      return _nativePage3Ad;
    }

    return NativeAd(
        adUnitId: Config.nativePage3Ad,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativePage3Ad();
            precacheNativePage3Ad();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePage3Ad();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Info Ad******************

  static void precacheNativeInfoAd() {
    log('Precache Native Info Ad - Id: ${Config.nativeInfoAd}');

    if (Config.hideAds) return;

    _nativeInfoAd = NativeAd(
        adUnitId: Config.nativeInfoAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeInfoAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeInfoAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeInfoAd() {
    _nativeInfoAd?.dispose();
    _nativeInfoAd = null;
    _nativeInfoAdLoaded = false;
  }

  static NativeAd? loadNativeInfoAd({required NativeAdController adController}) {
    log('Native Info Ad Id: ${Config.nativeInfoAd}');

    if (Config.hideAds) return null;

    if (_nativeInfoAdLoaded && _nativeInfoAd != null) {
      adController.adLoaded.value = true;
      return _nativeInfoAd;
    }

    return NativeAd(
        adUnitId: Config.nativeInfoAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeInfoAd();
            precacheNativeInfoAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeInfoAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Info Ad******************

  static void precacheNativeSelectAd() {
    log('Precache Native Select Ad - Id: ${Config.nativeSelectAd}');

    if (Config.hideAds) return;

    _nativeSelectAd = NativeAd(
        adUnitId: Config.nativeSelectAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeSelectAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeSelectAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeSelectAd() {
    _nativeSelectAd?.dispose();
    _nativeSelectAd = null;
    _nativeSelectAdLoaded = false;
  }

  static NativeAd? loadNativeSelectAd({required NativeAdController adController}) {
    log('Native Select Ad Id: ${Config.nativeSelectAd}');

    if (Config.hideAds) return null;

    if (_nativeSelectAdLoaded && _nativeSelectAd != null) {
      adController.adLoaded.value = true;
      return _nativeSelectAd;
    }

    return NativeAd(
        adUnitId: Config.nativeSelectAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeSelectAd();
            precacheNativeSelectAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeSelectAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Gun Ad******************

  static void precacheNativeGunAd() {
    log('Precache Native Gun Ad - Id: ${Config.nativeGunAd}');

    if (Config.hideAds) return;

    _nativeGunAd = NativeAd(
        adUnitId: Config.nativeGunAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeGunAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeGunAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeGunAd() {
    _nativeGunAd?.dispose();
    _nativeGunAd = null;
    _nativeGunAdLoaded = false;
  }

  static NativeAd? loadNativeGunAd({required NativeAdController adController}) {
    log('Native Gun Ad Id: ${Config.nativeGunAd}');

    if (Config.hideAds) return null;

    if (_nativeGunAdLoaded && _nativeGunAd != null) {
      adController.adLoaded.value = true;
      return _nativeGunAd;
    }

    return NativeAd(
        adUnitId: Config.nativeGunAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeGunAd();
            precacheNativeGunAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeGunAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Character Ad******************

  static void precacheNativeCharacterAd() {
    log('Precache Native Character Ad - Id: ${Config.nativeCharacterAd}');

    if (Config.hideAds) return;

    _nativeCharacterAd = NativeAd(
        adUnitId: Config.nativeCharacterAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeCharacterAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeCharacterAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeCharacterAd() {
    _nativeCharacterAd?.dispose();
    _nativeCharacterAd = null;
    _nativeCharacterAdLoaded = false;
  }

  static NativeAd? loadNativeCharacterAd({required NativeAdController adController}) {
    log('Native Character Ad Id: ${Config.nativeCharacterAd}');

    if (Config.hideAds) return null;

    if (_nativeCharacterAdLoaded && _nativeCharacterAd != null) {
      adController.adLoaded.value = true;
      return _nativeCharacterAd;
    }

    return NativeAd(
        adUnitId: Config.nativeCharacterAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeCharacterAd();
            precacheNativeCharacterAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeCharacterAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Pet Ad******************

  static void precacheNativePetAd() {
    log('Precache Native Pet  Ad - Id: ${Config.nativePetAd}');

    if (Config.hideAds) return;

    _nativePetAd = NativeAd(
        adUnitId: Config.nativePetAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativePetAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePetAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativePetAd() {
    _nativePetAd?.dispose();
    _nativePetAd = null;
    _nativePetAdLoaded = false;
  }

  static NativeAd? loadNativePetAd({required NativeAdController adController}) {
    log('Native Pet Ad Id: ${Config.nativePetAd}');

    if (Config.hideAds) return null;

    if (_nativePetAdLoaded && _nativePetAd != null) {
      adController.adLoaded.value = true;
      return _nativePetAd;
    }

    return NativeAd(
        adUnitId: Config.nativePetAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativePetAd();
            precacheNativePetAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativePetAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native Emotes Ad******************

  static void precacheNativeEmotesAd() {
    log('Precache Native Emotes Ad - Id: ${Config.nativeEmotesAd}');

    if (Config.hideAds) return;

    _nativeEmotesAd = NativeAd(
        adUnitId: Config.nativeEmotesAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeEmotesAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeEmotesAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeEmotesAd() {
    _nativeEmotesAd?.dispose();
    _nativeEmotesAd = null;
    _nativeEmotesAdLoaded = false;
  }

  static NativeAd? loadNativeEmotesAd({required NativeAdController adController}) {
    log('Native Emotes Ad Id: ${Config.nativeEmotesAd}');

    if (Config.hideAds) return null;

    if (_nativeEmotesAdLoaded && _nativeEmotesAd != null) {
      adController.adLoaded.value = true;
      return _nativeEmotesAd;
    }

    return NativeAd(
        adUnitId: Config.nativeEmotesAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeEmotesAd();
            precacheNativeEmotesAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeEmotesAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native LuckyGun Ad******************

  static void precacheNativeLuckyGunAd() {
    log('Precache Native LuckyGun Ad - Id: ${Config.nativeLuckyGunAd}');

    if (Config.hideAds) return;

    _nativeLuckyGunAd = NativeAd(
        adUnitId: Config.nativeLuckyGunAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeLuckyGunAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeLuckyGunAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeLuckyGunAd() {
    _nativeLuckyGunAd?.dispose();
    _nativeLuckyGunAd = null;
    _nativeLuckyGunAdLoaded = false;
  }

  static NativeAd? loadNativeLuckyGunAd({required NativeAdController adController}) {
    log('Native LuckyGun Ad Id: ${Config.nativeLuckyGunAd}');

    if (Config.hideAds) return null;

    if (_nativeLuckyGunAdLoaded && _nativeLuckyGunAd != null) {
      adController.adLoaded.value = true;
      return _nativeLuckyGunAd;
    }

    return NativeAd(
        adUnitId: Config.nativeLuckyGunAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeLuckyGunAd();
            precacheNativeLuckyGunAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeLuckyGunAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Native LuckyCharacter Ad******************

  static void precacheNativeLuckyCharacterAd() {
    log('Precache Native LuckyCharacter Ad - Id: ${Config.nativeLuckyCharacterAd}');

    if (Config.hideAds) return;

    _nativeLuckyCharacterAd = NativeAd(
        adUnitId: Config.nativeLuckyCharacterAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeLuckyCharacterAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeLuckyCharacterAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeLuckyCharacterAd() {
    _nativeLuckyCharacterAd?.dispose();
    _nativeLuckyCharacterAd = null;
    _nativeLuckyCharacterAdLoaded = false;
  }

  static NativeAd? loadNativeLuckyCharacterAd({required NativeAdController adController}) {
    log('Native LuckyCharacter Ad Id: ${Config.nativeLuckyCharacterAd}');

    if (Config.hideAds) return null;

    if (_nativeLuckyCharacterAdLoaded && _nativeLuckyCharacterAd != null) {
      adController.adLoaded.value = true;
      return _nativeLuckyCharacterAd;
    }

    return NativeAd(
        adUnitId: Config.nativeLuckyCharacterAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeLuckyCharacterAd();
            precacheNativeLuckyCharacterAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeLuckyCharacterAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
        NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Rewarded Ad******************

  static void showRewardedAd({required VoidCallback onComplete}) {
    log('Rewarded Ad Id: ${Config.rewardedAd}');

    if (Config.hideAdsBefore) {
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    RewardedAd.load(
      adUnitId: Config.rewardedAd,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          Get.back();

          //reward listener
          ad.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            onComplete();
          });
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an interstitial ad: ${err.message}');
          // onComplete();
        },
      ),
    );
  }

  //*****************Banner Ad******************

  static void precacheBannerAd() {
    log('Precache Banner Ad - Id: ${Config.bannerAd}');

    if (Config.hideAds) return;

    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerAd loaded.');
          _bannerAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerAd();
          log('BannerAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void _resetBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _bannerAdLoaded = false;
  }

  static BannerAd? loadBannerAd({required BannerAdController adController, VoidCallback? onLoaded}) {
    log('Load Banner Ad - Id: ${Config.bannerAd}');

    if (Config.hideAds) return null;

    // Nếu đã tải sẵn rồi thì trả về luôn
    if (_bannerAdLoaded && _bannerAd != null) {
      adController.adLoaded.value = true;
      if (onLoaded != null) onLoaded(); // ✅ success callback
      return _bannerAd;
    }

    // Trường hợp chưa precache được -> load mới
    return BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerAd loaded.');
          adController.adLoaded.value = true;
          // ✅ Chỉ gọi callback khi thành công
          if (onLoaded != null) onLoaded();
          _resetBannerAd();
          precacheBannerAd(); // Tự động preload lại
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerAd();
          log('BannerAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

//*****************Banner Home Ad******************

  static void precacheBannerHomeAd() {
    log('Precache Banner Home Ad - Id: ${Config.bannerHomeAd}');

    if (Config.hideAds) return;

    _bannerHomeAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerHomeAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerHomeAd loaded.');
          _bannerHomeAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerHomeAd();
          log('BannerHomeAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void _resetBannerHomeAd() {
    _bannerHomeAd?.dispose();
    _bannerHomeAd = null;
    _bannerHomeAdLoaded = false;
  }

  static BannerAd? loadBannerHomeAd({required BannerAdController adController, VoidCallback? onLoaded}) {
    log('Load Banner Home Ad - Id: ${Config.bannerHomeAd}');

    if (Config.hideAds) return null;

    // Nếu đã tải sẵn rồi thì trả về luôn
    if (_bannerHomeAdLoaded && _bannerHomeAd != null) {
      adController.adLoaded.value = true;
      if (onLoaded != null) onLoaded(); // ✅ success callback
      return _bannerHomeAd;
    }

    // Trường hợp chưa precache được -> load mới
    return BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerHomeAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerHomeAd loaded.');
          adController.adLoaded.value = true;
          // ✅ Chỉ gọi callback khi thành công
          if (onLoaded != null) onLoaded();
          _resetBannerHomeAd();
          precacheBannerHomeAd(); // Tự động preload lại
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerHomeAd();
          log('BannerHomeAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  //*****************Banner Detail Ad******************

  static void precacheBannerDetailAd() {
    log('Precache Banner Detail Ad - Id: ${Config.bannerDetailAd}');

    if (Config.hideAds) return;

    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerDetailAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerDetailAd loaded.');
          _bannerDetailAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerDetailAd();
          log('BannerAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void _resetBannerDetailAd() {
    _bannerDetailAd?.dispose();
    _bannerDetailAd = null;
    _bannerDetailAdLoaded = false;
  }

  static BannerAd? loadBannerDetailAd({required BannerAdController adController, VoidCallback? onLoaded}) {
    log('Load Banner Detail Ad - Id: ${Config.bannerDetailAd}');

    if (Config.hideAds) return null;

    // Nếu đã tải sẵn rồi thì trả về luôn
    if (_bannerDetailAdLoaded && _bannerDetailAd != null) {
      adController.adLoaded.value = true;
      if (onLoaded != null) onLoaded(); // ✅ success callback
      return _bannerDetailAd;
    }

    // Trường hợp chưa precache được -> load mới
    return BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerDetailAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerDetailAd loaded.');
          adController.adLoaded.value = true;
          // ✅ Chỉ gọi callback khi thành công
          if (onLoaded != null) onLoaded();
          _resetBannerDetailAd();
          precacheBannerDetailAd(); // Tự động preload lại
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerDetailAd();
          log('BannerDetailAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  //*****************Banner LuckyPet Ad******************

  static void precacheBannerLuckyPetAd() {
    log('Precache Banner LuckyPet Ad - Id: ${Config.bannerLuckyPetAd}');

    if (Config.hideAds) return;

    _bannerLuckyPetAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerLuckyPetAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerLuckyPetAd loaded.');
          _bannerLuckyPetAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerLuckyPetAd();
          log('BannerLuckyPetAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void _resetBannerLuckyPetAd() {
    _bannerLuckyPetAd?.dispose();
    _bannerLuckyPetAd = null;
    _bannerLuckyPetAdLoaded = false;
  }

  static BannerAd? loadBannerLuckyPetAd({required BannerAdController adController, VoidCallback? onLoaded}) {
    log('Load Banner LuckyPet Ad - Id: ${Config.bannerLuckyPetAd}');

    if (Config.hideAds) return null;

    // Nếu đã tải sẵn rồi thì trả về luôn
    if (_bannerLuckyPetAdLoaded && _bannerLuckyPetAd != null) {
      adController.adLoaded.value = true;
      if (onLoaded != null) onLoaded(); // ✅ success callback
      return _bannerLuckyPetAd;
    }

    // Trường hợp chưa precache được -> load mới
    return BannerAd(
      size: AdSize.banner,
      adUnitId: Config.bannerLuckyPetAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('BannerLuckyPetAd loaded.');
          adController.adLoaded.value = true;
          // ✅ Chỉ gọi callback khi thành công
          if (onLoaded != null) onLoaded();
          _resetBannerLuckyPetAd();
          precacheBannerLuckyPetAd(); // Tự động preload lại
        },
        onAdFailedToLoad: (ad, error) {
          _resetBannerLuckyPetAd();
          log('BannerLuckyPetAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

}

class BannerAdController {
  ValueNotifier<bool> adLoaded = ValueNotifier(false);
  BannerAd? bannerAd;

  void dispose() {
    adLoaded.dispose();
  }
}
