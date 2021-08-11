import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sunnydaydev_site/core/bloc_extensions.dart';
import 'package:sunnydaydev_site/core/url_launcher/url_launcher.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _aboutMeRepository = AboutMeRepository();

  HomeBloc() : super(HomeState());

  Stream<List<InfoItem>> get infos =>
      stateStream.map((state) => state.infos ?? []).distinct();

  Stream<List<ContactItem>> get contacts =>
      stateStream.map((state) => state.contacts ?? []).distinct();

  Stream<bool> get isLoading =>
      stateStream.map((state) => state.isLoading).distinct();

  final CompositeSubscription _dispose = CompositeSubscription();

  void initState() {
    _aboutMeRepository.contacts().listen((items) {
      add(ContactsLoaded(items));
    }).addTo(_dispose);

    _aboutMeRepository.infos().listen((items) {
      add(InfoItemsLoaded(items));
    }).addTo(_dispose);
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ContactSelected) {
      _contactSelected(event);
    } else if (event is InfoItemsLoaded) {
      yield _infosLoaded(event.items);
    } else if (event is ContactsLoaded) {
      yield _contactsLoaded(event.items);
    }
  }

  HomeState _contactsLoaded(List<ContactItem> items) => HomeState(
      infos: state.infos, contacts: items, isLoading: state.infos == null);

  HomeState _infosLoaded(List<InfoItem> items) => HomeState(
      infos: items,
      contacts: state.contacts,
      isLoading: state.contacts == null);

  void _contactSelected(ContactSelected event) async {
    String url;

    switch (event.contact.runtimeType) {
      case EmailContact:
        url = 'mailto:${event.contact.value}';
        break;
      case PhoneContact:
        url = 'tel:${event.contact.value}';
        break;
      case SkypeContact:
        url = 'skype:${event.contact.value}?chat';
        break;
      case TelegramContact:
        url = 'tg://resolve?domain=${event.contact.value}';
        break;
      default:
        return;
    }

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Future<void> close() {
    _dispose.dispose();

    return super.close();
  }
}
