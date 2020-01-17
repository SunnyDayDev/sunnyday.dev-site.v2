
import 'package:sunnydaydev_site/core/ui/custom_icons_icons.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_repository.dart';


class _AboutMeRepositoryImpl implements AboutMeRepository {

  Stream<List<InfoItem>> infos() async* {
    yield [
      InfoItem(
          title: "Android",
          icon: CustomIcons.android,
          message: "Опыт разработки более 6-ти лет. Работал со всем спектром Android SDK, в результате чего имею отличное понимание о «жизни» Андроида и его компонентов. Уважаю Java, люблю Kotlin."
      ),
      InfoItem(
          title: "iOS",
          icon: CustomIcons.apple,
          message: "Опыт разработки более 2-х лет. В основном Swift (новые приложения), но также занимался и поддержкой старых приложений написанных на Objective-C."
      ),
      InfoItem(
          title: "В общем",
          icon: CustomIcons.person,
          message: "Никогда не останавливаюсь на достигнутом и все время совершенствуюсь. Стараюсь быть в курсе текущего состояния дел, слежу за всем что творится в мире мобильной разработки и разработки в целом, посещаю конференции (Mobius, DroidCon, MBLTDev), мечтаю начать контрибьютить в open-source (сейчас кажется, что не хватает времени). Всегда открыт чему-то новому."
      )
    ];
  }

  Stream<List<ContactItem>> contacts() async* {
    yield [
      EmailContact("mail@sunnyday.dev"),
      PhoneContact("+7 (964) 382-8998"),
      SkypeContact("sunnyday.development"),
      TelegramContact("@sunnydaydev")
    ];
  }

}

AboutMeRepository getAboutMeRepository() => _AboutMeRepositoryImpl();