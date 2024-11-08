import 'package:flutter/material.dart';
import 'package:social_media/presentation/forgot_password/forgot_password_view.dart';
import 'package:social_media/presentation/login/login_view.dart';
import 'package:social_media/presentation/main/main_view.dart';
import 'package:social_media/presentation/onboarding/onboarding_view.dart';
import 'package:social_media/presentation/register/register_view.dart';
import 'package:social_media/presentation/resources/strings_Manager.dart';
import 'package:social_media/presentation/splash/splash_view.dart';

class routes{
  static const String splashRoute ="/";
  static const String loginRoute ="/login";
  static const String registerRoute ="/register";
  static const String onBoardingRoute ="/onBoarding";
  static const String forgotPasswordRoute ="/forgotPassword";
  static const String mainRoute ="/main";
  static const String storeRoute ="/store";
}
class routeGenerator{
  static Route <dynamic> getRoutes (RouteSettings settings){
    switch (settings.name){
      case routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>const splashView());
      case routes.loginRoute:
        return MaterialPageRoute(builder: (_)=>const loginView());
        case routes.onBoardingRoute:
      return MaterialPageRoute(builder: (_)=>const OnBoardingView());
      case routes.registerRoute:
        return MaterialPageRoute(builder: (_)=>const registerView());
      case routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_)=>const forgotPasswordView());
      case routes.mainRoute:
        return MaterialPageRoute(builder: (_)=>const main_view());
      default:
    return unDefinedRoute();
    }
  }

  static Route<dynamic>unDefinedRoute(){
      return MaterialPageRoute(builder: (_)=>Scaffold(appBar: AppBar(title: Text(appStrings.noRouteFound),),
        body: Center(child: Text(appStrings.noRouteFound),),));
    }
}