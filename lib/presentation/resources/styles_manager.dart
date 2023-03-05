
import 'package:flutter/material.dart';

import 'font_manager.dart';

  TextStyle _getTextStyle(FontWeight fontWeight,Color color , double fontSize){
    return TextStyle(fontSize: fontSize,fontWeight: fontWeight,color: color,fontFamily: FontConstants.fontFamily);
  }

  TextStyle getLightTextStyle({ required Color color,double fontSize = FontSize.s12}){
    return _getTextStyle( FontWeightManager.light , color, fontSize );
  }

  TextStyle getRegularTextStyle({ required Color color,double fontSize = FontSize.s14}){
    return _getTextStyle( FontWeightManager.regular , color, fontSize );
  }

  TextStyle getMediumTextStyle({ required Color color,double fontSize = FontSize.s16}){
    return _getTextStyle( FontWeightManager.medium , color, fontSize );
  }

  TextStyle getSemiBoldTextStyle({ required Color color,double fontSize = FontSize.s18}){
    return _getTextStyle( FontWeightManager.semiBold , color, fontSize );
  }

  TextStyle getBoldTextStyle({ required Color color,double fontSize = FontSize.s22}){
    return _getTextStyle( FontWeightManager.bold , color, fontSize );
  }






