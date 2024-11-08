import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/Cubit/States.dart';
import '../Login_Screen/Login-Screen.dart';
import '../Module/newPostScreen.dart';
import '../Network/Local/Cache_helper.dart';

class home_Layout extends StatelessWidget {
  const home_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=socialCubit.get(context);
    return BlocConsumer<socialCubit,socialStates>(
        listener: (context,state){
          if(state is socialNewPost){
            Navigator.push(context, MaterialPageRoute(builder:(context)=> const newPostScreen()));
            cubit.currentindex=0;

          }
        },
      builder:(context,state)=> Scaffold(

      body:cubit.screens[cubit.currentindex] ,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black12,
        currentIndex: cubit.currentindex,
        onTap:(index){
        cubit.currentindex=index;
        cubit.changeBottom(index);
      }, items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_fill),label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Ionicons.cloud_upload_outline),label: 'Post'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: 'Users'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),label: 'Settings'),
      ] ,

      ),

    ) ,
       );
  }
}
