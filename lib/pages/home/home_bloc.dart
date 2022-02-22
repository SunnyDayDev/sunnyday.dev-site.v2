import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sunnydaydev_site/core/bloc_extensions.dart';
import 'package:sunnydaydev_site/core/url_launcher/url_launcher.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _aboutMeRepository = AboutMeRepository();

  HomeBloc() : super(HomeState()) {
    on<ContactSelected>(_contactSelected);
    on<InfoItemsLoaded>(_infosLoaded);
    on<ContactsLoaded>(_contactsLoaded);
  }

  Stream<List<InfoItem>> get infos =>
      stateStream.map((state) => state.infos ?? []).distinct();

  Stream<List<ContactItem>> get contacts =>
      stateStream.map((state) => state.contacts ?? []).distinct();

  Stream<bool> get isLoading =>
      stateStream.map((state) => state.isLoading).distinct();

  final CompositeSubscription _dispose = CompositeSubscription();

  void initState() {
    _listenEvents(_aboutMeRepository
        .contacts()
        .map((contacts) => ContactsLoaded(contacts)));

    _listenEvents(
        _aboutMeRepository.infos().map((items) => InfoItemsLoaded(items)));
  }

  void _listenEvents(Stream<HomeEvent> events) =>
      events.listen(add).addTo(_dispose);

  void _contactsLoaded(ContactsLoaded event, Emitter<HomeState> emit) =>
      emit(HomeState(
          infos: state.infos,
          contacts: event.items,
          isLoading: state.infos == null));

  void _infosLoaded(InfoItemsLoaded event, Emitter<HomeState> emit) =>
      emit(HomeState(
          infos: event.items,
          contacts: state.contacts,
          isLoading: state.contacts == null));

  void _contactSelected(ContactSelected event, Emitter<HomeState> emit) async {
    var url = _getContactUrl(event.contact);
    if (url == null) return;

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  String? _getContactUrl(ContactItem item) {
    switch (item.runtimeType) {
      case EmailContact:
        return 'mailto:${item.value}';
      case PhoneContact:
        return 'tel:${item.value}';
      case SkypeContact:
        return 'skype:${item.value}?chat';
      case TelegramContact:
        return 'tg://resolve?domain=${item.value}';
      default:
        return null;
    }
  }

  @override
  Future<void> close() {
    _dispose.dispose();

    return super.close();
  }
}
