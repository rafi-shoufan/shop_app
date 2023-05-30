import 'dart:async';

import 'package:advanced/app/app_preferences.dart';
import 'package:advanced/app/dependency_injection.dart';
import 'package:advanced/presentation/resources/constants_manager.dart';
import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppPreferences appPreferences = instance<AppPreferences>();

  Timer ? _timer ;
  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay),_goNext);
  }
  _goNext() async {
    if(await appPreferences.isUserLoggedIn()){
      Navigator.pushReplacementNamed(context, Routes.mainRoute);

    }else{
      if(await appPreferences.isOnBoardingScreenViewed()){
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }else{
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
      }
    }
  }


  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child:   Image(
              image: AssetImage(ImageAssets.splashLogo)
          )
      ),
    );
  }
}
