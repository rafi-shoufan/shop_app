import 'package:advanced/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:advanced/presentation/login/view/login_view.dart';
import 'package:advanced/presentation/main/view/main_view.dart';
import 'package:advanced/presentation/onboarding/view/onboarding_view.dart';
import 'package:advanced/presentation/register/view/register_view.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:advanced/presentation/splash/splash_view.dart';
import 'package:advanced/presentation/store_details/store_details_view.dart';
import 'package:easy_localization/easy_localization.dart';
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

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute :
        return MaterialPageRoute(builder: (context) => const SplashView(),);

      case Routes.onBoarding :
        return MaterialPageRoute(builder: (context) => const OnBoardingView(),);

      case Routes.loginRoute :
        initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginView(),);

      case Routes.registerRoute :
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterView(),);

      case Routes.forgotPasswordRoute :
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),);

      case Routes.mainRoute :
        initHomeModule();
        return MaterialPageRoute(builder: (context) => const MainView(),);

      case Routes.storeDetailsRoute :
        return MaterialPageRoute(
          builder: (context) => const StoreDetailsView(),);
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {

    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title:  Text(AppStrings.noRouteFound.tr()),
        ),
        body:  Center(
          child:  Text(
              AppStrings.noRouteFound.tr()
          ),
        ),
      );
    },);
  }

}
