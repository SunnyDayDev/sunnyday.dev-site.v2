import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState {
  final List<InfoItem> infos;
  final List<ContactItem> contacts;

  HomeState({@required this.infos, @required this.contacts});
}

class InitialHomeState extends HomeState {
  @override
  List<InfoItem> get infos => [
    InfoItem(title: "Android", icon: Icons.android, message: "Опыт разработки более 6-х лет. Работал со всем спектром Android SDK, в результате чего имею отличное понимание о «жизни» Андроида и его компонентов. Уважаю Java, люблю Kotlin."),
    InfoItem(title: "iOS", icon: Icons.android, message: "Опыт разработки более 2-х лет. В основном Swift (новые приложения), но также занимался и поддержкой старых приложений написанных на Objective-C."),
    InfoItem(title: "В общем", icon: Icons.person, message: "Никогда не останавливаюсь на достигнутом и все время совершенствуюсь. Стараюсь быть в курсе текущего состояния дел, слежу за всем что творится в мире мобильной разработки и разработки в целом, посещаю конференции (Mobius, DroidCon, MBLTDev), мечтаю начать контрибьютить в open-source. Всегда открыт чему-то новому.")
  ];
  
  @override
  List<ContactItem> get contacts => [
    EmailContact("mail@sunnyday.dev"),
    PhoneContact("+7 (964) 382-8998"),
    SkypeContact("sunnyday.development"),
    TelegramContact("@sunnydaydev")
  ];
}

@immutable
class InfoItem {
  final IconData icon;
  final String title;
  final String message;

  InfoItem({@required this.icon, @required this.title, @required this.message});
}

@immutable
abstract class ContactItem {
  final IconData icon;
  final String value;

  ContactItem(this.icon, this.value);
}

class EmailContact extends ContactItem {
  EmailContact(String value) : super(Icons.email, value);
}

class PhoneContact extends ContactItem {
  PhoneContact(String value) : super(Icons.phone, value);
}

class TelegramContact extends ContactItem {
  TelegramContact(String value) : super(Icons.send, value);
}

class SkypeContact extends ContactItem {
  SkypeContact(String value) : super(Icons.person, value);
}