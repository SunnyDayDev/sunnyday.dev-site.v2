import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sunnydaydev_site/core/ui/custom_icons_icons.dart';

part 'about_me_models.g.dart';

@autoequal
class InfoItem extends Equatable {
  final IconData icon;
  final String title;
  final String message;

  InfoItem({required this.icon, required this.title, required this.message});

  @override
  List<Object?> get props => _autoequalProps;
}

@autoequal
class ContactItem extends Equatable {
  final IconData icon;
  final String value;
  final ContactItemKind kind;

  ContactItem._(this.icon, this.value, this.kind);

  ContactItem.email(String email): this._(CustomIcons.email, email, ContactItemKind.EMAIL);

  ContactItem.phone(String phone): this._(CustomIcons.local_phone, phone, ContactItemKind.PHONE);

  ContactItem.telegram(String id): this._(CustomIcons.send, id, ContactItemKind.TELEGRAM);

  ContactItem.skype(String id): this._(CustomIcons.skype, id, ContactItemKind.SKYPE);

  ContactItem.unknown(String value): this._(CustomIcons.person, value, ContactItemKind.UNKNOWN);

  @override
  List<Object?> get props => _autoequalProps;
}

enum ContactItemKind {
  PHONE, EMAIL, TELEGRAM, SKYPE, UNKNOWN
}