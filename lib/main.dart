import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:restaurants_app/presentation/resources/language_manager.dart';

import 'app/app.dart';
import 'app/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroundHandler);
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  runApp(EasyLocalization(
      child: Phoenix(child: MyApp()),
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS));
}
