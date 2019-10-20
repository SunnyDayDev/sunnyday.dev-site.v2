import 'package:meta/meta.dart';
import 'package:sunnydaydev_site/pages/home/bloc.dart';

@immutable
abstract class HomeEvent {}

class ContactSelected extends HomeEvent {
  final ContactItem contact;

  ContactSelected(this.contact);
}
