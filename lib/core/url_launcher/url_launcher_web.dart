import 'package:sunnydaydev_site/core/url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

class WebUrlLauncher implements UrlLauncher {
  @override
  Future<bool> canLaunch(String url) async {
    return true;
  }

  @override
  Future<bool> launch(String url) async {
    html.window.location.href = url;
    return true;
  }
}

UrlLauncher getUrlLauncher() => WebUrlLauncher();
