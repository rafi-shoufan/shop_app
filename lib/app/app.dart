import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:advanced/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:RouteGenerator.getRoute ,
      initialRoute: Routes.splashRoute,
      theme: getAppTheme(),
    );
  }
}


