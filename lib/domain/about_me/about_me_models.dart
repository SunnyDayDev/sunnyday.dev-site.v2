
import 'package:flutter/widgets.dart';
import 'package:sunnydaydev_site/core/ui/custom_icons_icons.dart';


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

  const ContactItem(this.icon, this.value);
}

class EmailContact extends ContactItem {
  const EmailContact(String value) : super(CustomIcons.email, value);
}

class PhoneContact extends ContactItem {
  const PhoneContact(String value) : super(CustomIcons.local_phone, value);
}

class TelegramContact extends ContactItem {
  const TelegramContact(String value) : super(CustomIcons.send, value);
}

class SkypeContact extends ContactItem {
  const SkypeContact(String value) : super(CustomIcons.skype, value);
}