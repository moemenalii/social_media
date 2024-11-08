import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Style/style.dart';
import 'package:social_media/firebase_options.dart';
import 'Cubit/Cubit.dart';
import 'Login_Screen/Login-Screen.dart';
import 'Network/Local/Cache_helper.dart';
import 'Network/constant.dart';
import 'home_Layout/home_Layout.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
//flutter build apk --split-per-abi  ==> to build apk
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //معناه يشغل كل الفانكشن ال async بعدين يشغل الابليكشن
  // when app is open
  FirebaseMessaging.onMessage.listen((onData) {
    print('success');
  }).onError((handleError) {
    print('${handleError.toString()}');
  });
  // when a click to open app
  FirebaseMessaging.onMessageOpenedApp.listen((onData) {
    print('success');
  }).onError((handleError) {
    print('${handleError.toString()}');
  });  // when app is close
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
// var uId =CacheHelper.GetData(Key: 'uId');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    uId = CacheHelper.GetData(Key: 'uId');

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => socialCubit()
                ..getUserData()
                ..getPosts()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            iconButtonTheme: IconButtonThemeData(style: ButtonStyle( iconColor:WidgetStatePropertyAll(Colors.blue) )),
            hoverColor: Colors.blue,
              focusColor: Colors.blue,
              primarySwatch: Colors.blue,
              primaryColorLight: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
            // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.blue),
            primaryColor: Colors.blue
          ),
          themeMode: ThemeMode.light,
          darkTheme: darkTheme,
          // home: splashView(),
          home: uId != null ? home_Layout() : LoginScreen(),
        ));
  }
}
