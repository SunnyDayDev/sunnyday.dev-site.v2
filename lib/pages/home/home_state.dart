import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';

@immutable
class HomeState {
  final List<InfoItem> infos;
  final List<ContactItem> contacts;

  HomeState({@required this.infos, @required this.contacts});
}

class InitialHomeState implements HomeState {
  @override
  List<InfoItem> get infos => [];
  
  @override
  List<ContactItem> get contacts => [];
}