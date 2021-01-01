import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:health_box/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {


  runApp(EasyLocalization(
      saveLocale: true,
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: 'lang',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: [Locale('en', 'US')],
      locale: context.locale/*=="ar_DZ"?Locale('en', 'US'):Locale('en', 'US')*/,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen());
  }
}
