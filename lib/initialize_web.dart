import 'dart:convert';

import 'package:firebase/firebase.dart';
import 'package:flutter/services.dart';

Future<void> initialize() async {
  final secrets = jsonDecode(await rootBundle
      .loadString("assets/secrets/firebase.json", cache: false));

  initializeApp(
      apiKey: secrets["apiKey"],
      databaseURL: secrets["databaseURL"],
      projectId: secrets["projectId"],
      appId: secrets["appId"],);
}
