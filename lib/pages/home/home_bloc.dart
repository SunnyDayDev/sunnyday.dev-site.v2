import 'dart:async';
import 'package:universal_html/prefer_sdk/html.dart' as html;
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  final BuildContext context;

  HomeBloc(this.context);
  
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
    if (event is ContactSelected) {
      _contactSelected(event);
    }
  }
  
  void _contactSelected(ContactSelected event) async {
    String url;
    if (event.contact is EmailContact) {
      url = "mailto:${event.contact.value}";
    } else if (event.contact is PhoneContact) {
      url = "tel:${event.contact.value}";
    } else if (event.contact is SkypeContact) {
      url = "skype:${event.contact.value}?chat";
    } else if (event.contact is TelegramContact) {
      url = "tg://resolve?domain=${event.contact.value}";
    } else {
      return;
    }
    
    html.window.location.href = url;
  }
}
