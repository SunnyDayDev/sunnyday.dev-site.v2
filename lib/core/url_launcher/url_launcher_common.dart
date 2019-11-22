import 'package:sunnydaydev_site/core/url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class CommonUrlLauncher implements UrlLauncher {

  Future<bool> canLaunch(String url) => launcher.canLaunch(url);

  Future<bool> launch(String url) => launcher.launch(url);

}

UrlLauncher getUrlLauncher() => CommonUrlLauncher();