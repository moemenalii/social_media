import 'package:flutter/material.dart';
import 'color_Manager.dart';
import 'values_Manager.dart';
import 'styles_Manager.dart';
import 'fonts_Manager.dart';

ThemeData getAppTheme(){
  return ThemeData(
    //main Color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.grey,
    primaryColorDark: ColorManager.c3,
    disabledColor: ColorManager.c4,
    splashColor: ColorManager.grey,
    //card Theme
    cardTheme: CardTheme(
      color: ColorManager.grey,
      shadowColor: ColorManager.c4,
      elevation: appSize.s4,
    ),
    //app bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: appSize.s4,
      shadowColor: ColorManager.grey,
      titleTextStyle: getRegularStyle(FontSize: FontSize.s16,Color: ColorManager.grey,)
    ),
    //button Theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.grey,
      splashColor:  ColorManager.c3,
    ),
   
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(Color: ColorManager.c4,FontSize: FontSize.s14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appSize.s12),
        )
      )
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getLightStyle(Color: Colors.white,FontSize: FontSize.s22),
      headlineMedium: getSemiBoldStyle(Color: Colors.blueGrey,FontSize: FontSize.s16),
      headlineSmall: getMediumStyle(Color: Colors.grey,FontSize: FontSize.s14),
      titleMedium: getRegularStyle(Color: Colors.black12),
      titleLarge: getRegularStyle(Color: Colors.black12),
    ),
      //textFormField
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(appPadding.p8),
      hintStyle: getRegularStyle(Color: Colors.grey,FontSize: FontSize.s14),
      labelStyle: getMediumStyle(Color: Colors.grey,FontSize: FontSize.s14),
      errorStyle: getRegularStyle(Color: Colors.red),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary,width: appSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(appSize.s8))
      ),
      focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey,width: appSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(appSize.s8))
      ),
      errorBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.c3,width: appSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(appSize.s8))
      ),
      focusedErrorBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: appSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(appSize.s8))
      ),
    ),


  );
}