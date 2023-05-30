
import 'dart:ui';

import 'package:advanced/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFERED_KEY_LANG = 'PREFERED_KEY_LANG';
const String PREFERED_KEY_ONBOARDING_SCREEN_VIEWED = 'PREFERED_KEY_ONBOARDING_SCREEN_VIEWED';
const String PREFERED_KEY_IS_USER_LOGGED_IN = 'PREFERED_KEY_IS_USER_LOGGED_IN';


class AppPreferences{

  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async{
    String ? language = _sharedPreferences.getString(PREFERED_KEY_LANG);
    if(language != null && language.isNotEmpty){
      return language;
    }else{
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<Locale> getLocal() async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.ENGLISH.getValue()){
      return ENGLISH_LOCAL;
    }else{
      return ARABIC_LOCAL;
    }
  }
  
  Future<void> changeAppLanguage() async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.ENGLISH.getValue()){
      _sharedPreferences.setString(PREFERED_KEY_LANG, LanguageType.ARABIC.getValue());
    }else{
      _sharedPreferences.setString(PREFERED_KEY_LANG, LanguageType.ENGLISH.getValue());
    }
  }

  /// on boarding
   Future<void> setOnBoardingScreenViewed() async{
     _sharedPreferences.setBool(PREFERED_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async{
   return _sharedPreferences.getBool(PREFERED_KEY_ONBOARDING_SCREEN_VIEWED)?? false;
  }

  /// login

  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(PREFERED_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFERED_KEY_IS_USER_LOGGED_IN)?? false;
  }

  /// logout
  Future<void> logout() async{
    /// ممكن نستخدم احدى الطريقتين
    _sharedPreferences.remove(PREFERED_KEY_IS_USER_LOGGED_IN);
   // _sharedPreferences.setBool(PREFERED_KEY_IS_USER_LOGGED_IN, false);

  }




}