import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';

@immutable
class HomeState {
  final List<InfoItem>? infos;
  final List<ContactItem>? contacts;
  final bool isLoading;

  HomeState({this.infos, this.contacts, this.isLoading = true});
}
