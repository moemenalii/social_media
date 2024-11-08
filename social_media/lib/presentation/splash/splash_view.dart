import 'dart:async';

import 'package:flutter/material.dart';

import '../resources/routes_Manager.dart';

class splashView extends StatefulWidget {
  const splashView({Key? key}) : super(key: key);

  @override
  State<splashView> createState() => _splashViewState();
}

class _splashViewState extends State<splashView> {
  Timer ? _timer;
  _startDely(){
    _timer= Timer(Duration(seconds: 2),_goNext);
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, routes.onBoardingRoute);
  }
  @override
  void initState() {
    _startDely();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color:Colors.orange,child: Image(image: AssetImage(''))),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
