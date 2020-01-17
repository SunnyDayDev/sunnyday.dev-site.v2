import 'url_launcher_common.dart'
  if (dart.library.html) 'url_launcher_web.dart';

Future<void> launch(String url) => UrlLauncher().launch(url);
Future<bool> canLaunch(String url) => UrlLauncher().canLaunch(url);

abstract class UrlLauncher {

  Future<bool> canLaunch(String url);

  Future<bool> launch(String url);

  factory UrlLauncher() => getUrlLauncher();

}