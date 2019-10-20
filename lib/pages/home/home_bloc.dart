import 'dart:async';
import 'dart:html' as html;
import 'package:bloc/bloc.dart';
import './bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();
  
  Stream<List<InfoItem>> get infos =>
    map((state) => state.infos).distinct();
  
  Stream<List<ContactItem>> get contacts =>
    map((state) => state.contacts).distinct();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ContactSelected:
        _contactSelected(event as ContactSelected);
    }
  }
  
  void _contactSelected(ContactSelected event) {
    switch (event.contact.runtimeType) {
      case EmailContact:
        html.window.open("mailto:${event.contact.value}", "MailTo");
        break;
      case PhoneContact:
        html.window.open("tel:${event.contact.value}", "Phone");
        break;
      case SkypeContact:
        html.window.open("skype:${event.contact.value}?chat", "Skype");
        break;
      case TelegramContact:
        html.window.open("tg://resolve?domain=${event.contact.value}", "Telegram");
        break;
    }
  }
}
