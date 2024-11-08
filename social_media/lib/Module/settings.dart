import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Components/Components(tools).dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:social_media/Cubit/States.dart';
import 'package:social_media/Module/edit%20profile.dart';
import 'package:social_media/Network/Local/Cache_helper.dart';

import '../Login_Screen/Login-Screen.dart';
class settingsScreen extends StatelessWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var _userModel = socialCubit.get(context).model;
    var cubit=socialCubit.get(context);

    return BlocConsumer<socialCubit,socialStates>(
      listener:(context,state){} ,
      builder:(context,state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.chevron_left,size: 30,)),
            title: Text(cubit.titles[cubit.currentindex],style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: (){
                CacheHelper.removeData(Key: 'uId').then((value){
                  if(value){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }
                });}, icon: Icon(Icons.logout_sharp),),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(
                                '${_userModel!.cover}'
                            ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadiusDirectional.circular(5.0),
                          ),

                        ),
                      ),
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              '${_userModel.image}'
                          ),
                      )
                      )
                    ],
                  ),
                ),
                Text('${_userModel.name}', style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,),
                Text('${_userModel.bio}', style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('${socialCubit.get(context).posts.length}', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                              Text('posts', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('29', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                              Text('photos', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('10', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                              Text('followers', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('90', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                              Text('following', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                     Expanded(
                       child: defultButton(
                            label: 'Edit Profile', onPressed: () {}),
                     ),
                    SizedBox(width: 10,),
                    OutlinedButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>editProfile()));
                    }, child:Icon(Icons.edit,color: Colors.blue,),),
                  ],
                )

              ],
            ),
          ),
        );
      }
    );
  }
}
