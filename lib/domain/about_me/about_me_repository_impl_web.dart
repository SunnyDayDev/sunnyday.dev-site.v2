
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunnydaydev_site/core/ui/custom_icons_icons.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_repository.dart';


class _AboutMeRepositoryImpl implements AboutMeRepository {

  Stream<List<InfoItem>> infos() {
    Firestore store = firestore();
    CollectionReference ref = store.collection('about_me_infos');

    return ref.onSnapshot
      .map((snapshot) =>
        snapshot.docs.map((doc) =>
          InfoItem(
            title: doc.get("title"),
            icon: _getIcon(doc.get("icon")),
            message: doc.get("description")
          )
        ).toList()
      );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case "android": return CustomIcons.android;
      case "apple": return CustomIcons.apple;
      case "person": return CustomIcons.person;
      default: return Icons.adjust;
    }
  }

  Stream<List<ContactItem>> contacts() {

    Firestore store = firestore();
    CollectionReference ref = store.collection('my_contacts');

    return ref.onSnapshot
      .map((snapshot) =>
        snapshot.docs.map((doc) {
          switch (doc.get("type")) {
            case "email": return EmailContact(doc.get("value"));
            case "phone": return PhoneContact(doc.get("value"));
            case "telegram": return TelegramContact(doc.get("value"));
            case "skype": return SkypeContact(doc.get("value"));
            default: return PureContact(doc.get("value"));
          }
        }).toList()
      );
  }

}

AboutMeRepository getAboutMeRepository() => _AboutMeRepositoryImpl();