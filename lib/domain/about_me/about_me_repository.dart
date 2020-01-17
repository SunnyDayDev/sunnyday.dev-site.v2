
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';
import 'about_me_repository_impl_other.dart'
  if (dart.library.html) 'about_me_repository_impl_web.dart';


abstract class AboutMeRepository {

  Stream<List<InfoItem>> infos();

  Stream<List<ContactItem>> contacts();

  factory AboutMeRepository() => getAboutMeRepository();

}