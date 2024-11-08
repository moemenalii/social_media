import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme=ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      titleTextStyle:TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 20) ,
      systemOverlayStyle:SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness:Brightness.dark,
      ) ,
      iconTheme:IconThemeData(color: Colors.black ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed ,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor:Colors.white,
    ),
    textTheme:TextTheme(
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,)

    )
);
ThemeData darkTheme=ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: HexColor("#333739"),
    appBarTheme:  AppBarTheme(
      color: HexColor("#333739"),
      elevation: 0.0,
      titleTextStyle:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20) ,
      systemOverlayStyle:SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness:Brightness.light,
      ) ,
      iconTheme:IconThemeData(color: Colors.white ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed ,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor:HexColor("#333739"),
    ),
    textTheme:TextTheme(
        bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,) )
);