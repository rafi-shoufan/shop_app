import 'package:advanced/presentation/forgot_password/forgot_password_view.dart';
import 'package:advanced/presentation/login/view/login_view.dart';
import 'package:advanced/presentation/main/main_view.dart';
import 'package:advanced/presentation/onboarding/view/onboarding_view.dart';
import 'package:advanced/presentation/register/register_view.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:advanced/presentation/splash/splash_view.dart';
import 'package:advanced/presentation/store_details/store_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/dependency_injection.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
  static const String onBoarding = '/onBoarding';

}

class RouteGenerator{

  static Route<dynamic> getRoute(RouteSettings settings){

    switch(settings.name){
      case Routes.splashRoute :
        return MaterialPageRoute(builder: (context) => const SplashView(),);
    }
    switch(settings.name){
      case Routes.onBoarding :
        return MaterialPageRoute(builder: (context) => const OnBoardingView(),);
    }
    switch(settings.name){
      case Routes.loginRoute :
        initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginView(),);
    }
    switch(settings.name){
      case Routes.registerRoute :
        return MaterialPageRoute(builder: (context) => const RegisterView(),);
    }
    switch(settings.name){
      case Routes.forgotPasswordRoute :
        return MaterialPageRoute(builder: (context) => const ForgotPasswordView(),);
    }
    switch(settings.name){
      case Routes.mainRoute :
        return MaterialPageRoute(builder: (context) => const MainView(),);
    }
    switch(settings.name){
      case Routes.storeDetailsRoute :
        return MaterialPageRoute(builder: (context) => const StoreDetailsView(),);
    }
    return unDefinedRoute();
  }

  static Route<dynamic> unDefinedRoute() {

    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child:  Text(
              AppStrings.noRouteFound
          ),
        ),
      );
    },);
  }

}
