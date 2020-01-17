import 'platform_detect.dart';

class CommonPlatformDetector implements PlatformDetector {

  @override
  bool get isBrowser => false;

  @override
  bool get isSafariBrowser => false;

}

PlatformDetector getPlatformDetector() => CommonPlatformDetector();