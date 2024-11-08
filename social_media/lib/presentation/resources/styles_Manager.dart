import 'package:flutter/material.dart';
import 'fonts_Manager.dart';
TextStyle _getTextStyle(double FontSize,FontWeight FontWeight,Color Color){
  return TextStyle(
    fontSize: FontSize,
    fontFamily: FontConstant.FontFamily,
    fontWeight: FontWeight,
    color: Color,
  );
}
TextStyle getRegularStyle(
    {double FontSize = FontSize.s12,  required Color Color}){
  return _getTextStyle(FontSize,FontWeightManager.regular,Color) ;
}

TextStyle getMediumStyle(
    {double FontSize = FontSize.s12,  required Color Color}){
  return _getTextStyle(FontSize,FontWeightManager.medium,Color) ;
}
TextStyle getSemiBoldStyle(
    {double FontSize = FontSize.s12,  required Color Color}){
  return _getTextStyle(FontSize,FontWeightManager.Semi_bold,Color) ;
}
TextStyle getBoldStyle(
    {double FontSize = FontSize.s12,  required Color Color}){
  return _getTextStyle(FontSize,FontWeightManager.bold,Color) ;
}

TextStyle getLightStyle(
    {double FontSize = FontSize.s12,  required Color Color}){
  return _getTextStyle(FontSize,FontWeightManager.light,Color) ;
}
