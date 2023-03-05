import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/styles_manager.dart';
import 'package:advanced/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';


  getAppTheme(){
    return ThemeData(
      /// main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor:ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      /// card theme
      cardTheme : CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4
      ),
      /// app bar theme
      appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        elevation: AppSize.s14,
        shadowColor: ColorManager.lightPrimary,
        centerTitle: true,
        titleTextStyle: getRegularTextStyle(color: ColorManager.white,fontSize: AppSize.s16),
      ),
      /// button theme
      buttonTheme: ButtonThemeData(
        buttonColor: ColorManager.primary,
        disabledColor: ColorManager.grey,
        shape: StadiumBorder(),
        splashColor: ColorManager.lightPrimary
      ),
      /// elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(AppSize.s12),
         ),
          textStyle: getRegularTextStyle(color: ColorManager.white,fontSize: FontSize.s17 ),
          primary: ColorManager.primary
        )
        ),
      /// text theme
      textTheme: TextTheme(
        displayLarge: getSemiBoldTextStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s16,
        ),
        headlineLarge: getSemiBoldTextStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s16,
        ),
        headlineMedium: getRegularTextStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s14,
        ),
        titleMedium: getMediumTextStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s16
        ),
        bodyLarge: getRegularTextStyle(
            color: ColorManager.grey1,
        ),
        bodySmall: getRegularTextStyle(
            color: ColorManager.grey
        ) ,
      ),
      /// input decoration theme
      inputDecorationTheme: InputDecorationTheme(

        labelStyle: getMediumTextStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s14
        ),
        hintStyle: getRegularTextStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s14
        ),
        errorStyle: getRegularTextStyle(color: ColorManager.error),
        contentPadding: const EdgeInsets.all(AppPadding.p8),


       // enabled border
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.grey,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),



        // focused border
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),



        // error border
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.error,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),



        // focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      ),

    );
  }
