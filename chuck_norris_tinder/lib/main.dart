import 'dart:async';

import 'package:chuck_norris_tinder/Models/constants.dart';
import 'package:chuck_norris_tinder/no_connection_screen.dart';
import 'package:chuck_norris_tinder/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main_screen.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return MaterialApp(
        title: appTitle,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RUS'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: ref.watch(connectionProvider)
            ? const MyHomePage()
            : const NoConnectionScreen()
    );
  }
}