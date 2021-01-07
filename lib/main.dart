import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:health_box/network/home_bloc.dart';
import 'package:health_box/screens/home/homeScreen.dart';
import 'package:health_box/screens/splash.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fcm/PushNotificationsManager.dart';
import 'network/api_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationsManager().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(EasyLocalization(
      saveLocale: true,
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: 'lang',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var islogin;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    iswork();
  }

  iswork() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      islogin = sharedPreferences.getBool(LocalStorage.isLogin);
    });
    print("ig ${islogin}");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) {
              return HomeBloc(apiRepository: APIRepository());
            },
            child: islogin == true ? HomeScreen() : SplashScreen(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: [Locale('en', 'US')],
            locale: context
                .locale/*=="ar_DZ"?Locale('en', 'US'):Locale('en', 'US')*/,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: islogin == true ? HomeScreen() : SplashScreen()));
  }
}
