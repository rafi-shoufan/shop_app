import 'package:advanced/app/app_preferences.dart';
import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:advanced/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'dependency_injection.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();
  static final MyApp _instance = MyApp._internal();

  factory MyApp(){
    return _instance;
  }

  int appState = 0;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((value) => context.setLocale(value));
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute:RouteGenerator.getRoute ,
      initialRoute: Routes.splashRoute,
      theme: getAppTheme(),
    );
  }
}


