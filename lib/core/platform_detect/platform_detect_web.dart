import 'platform_detect.dart';
import 'package:platform_detect/platform_detect.dart';

class WebPlatformDetector implements PlatformDetector {

  @override
  bool get isBrowser => true;

  @override
  bool get isSafariBrowser => browser.isSafari || browser.isWKWebView;

}

PlatformDetector getPlatformDetector() => WebPlatformDetector();