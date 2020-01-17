import 'package:meta/meta.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';

@immutable
abstract class HomeEvent {}

class ContactsLoaded implements HomeEvent {
  final List<ContactItem> items;

  ContactsLoaded(this.items);
}

class InfoItemsLoaded implements HomeEvent {
  final List<InfoItem> items;

  InfoItemsLoaded(this.items);
}

class ContactSelected implements HomeEvent {
  final ContactItem contact;

  const ContactSelected(this.contact);
}
