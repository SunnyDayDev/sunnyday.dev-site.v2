import 'platform_detect_other.dart'
  if (dart.library.html) 'platform_detect_web.dart';


class PlatformDetect {

  static final _detector = PlatformDetector();

  static bool get isBrowser => _detector.isBrowser;
  static bool get isSafariBrowser => _detector.isSafariBrowser;

}

abstract class PlatformDetector {

  bool get isBrowser;
  bool get isSafariBrowser;

  /// factory constructor to return the correct implementation.
  factory PlatformDetector() => getPlatformDetector();
}