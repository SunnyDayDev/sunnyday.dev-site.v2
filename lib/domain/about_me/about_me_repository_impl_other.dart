
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_repository.dart';


class _AboutMeRepositoryImpl implements AboutMeRepository {

  Stream<List<InfoItem>> infos() {
    throw Error();
  }

  Stream<List<ContactItem>> contacts() {
    throw Error();
  }

}

AboutMeRepository getAboutMeRepository() => _AboutMeRepositoryImpl();