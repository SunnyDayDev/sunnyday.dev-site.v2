import 'package:meta/meta.dart';
import 'package:sunnydaydev_site/pages/home/bloc.dart';

@immutable
abstract class HomeEvent {}

class ContactSelected implements HomeEvent {
  final ContactItem contact;

  const ContactSelected(this.contact);
}
