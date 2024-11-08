import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Components/Components(tools).dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:social_media/Cubit/States.dart';

class editProfile extends StatelessWidget {

  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _userModel = socialCubit.get(context).model;

    nameController.text=_userModel!.name!;
    bioController.text=_userModel.bio!;
    phoneController.text=_userModel.phone!;
    return BlocConsumer<socialCubit,socialStates>(
      listener:(context,state){} ,
      builder: (context,state){
        dynamic profileImage =socialCubit.get(context).profileImage;
        dynamic coverImage =socialCubit.get(context).CoverImage;
        return Scaffold(
        appBar: AppBar(
          title: Text('Edite Profile',style: TextStyle(color: Colors.blue),),
          actions: [
            TextButton(child:Text ('UPDATE',style: TextStyle(color: Colors.blue)), onPressed: (){
              // socialCubit.get(context).updateUserImage(name:nameController.text,phone:phoneController.text,bio: bioController.text);
              socialCubit.get(context).updateUser(name:nameController.text,phone:phoneController.text,bio: bioController.text);
            })
          ],
        ),
        body: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              if(state is socialUpdateUserLoading)
               LinearProgressIndicator(),
            SizedBox(height: 10,),
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            height: 140,
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              image: DecorationImage(image:coverImage ==null? NetworkImage(
                                  '${_userModel.cover}'
                              ): FileImage(coverImage)as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadiusDirectional.circular(5.0),
                            ),

                          ),
                          CircleAvatar(
                            backgroundColor:  Colors.white,
                            child: IconButton(onPressed: (){
                            socialCubit.get(context).getcoverImage();
                          },icon: Icon(Icons.camera_alt_outlined,color: Colors.blue),),),
                        ],
                      ),
                    ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                        radius: 55,
                        backgroundColor: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:profileImage ==null ? NetworkImage(
                              '${_userModel.image}'
                          ) :FileImage(profileImage) as ImageProvider,
                        ),
                    ),
                    CircleAvatar(
                      backgroundColor:  Colors.white,
                      child: IconButton(onPressed: (){
                      socialCubit.get(context).getProfileImage();
                    },icon: Icon(Icons.camera_enhance_outlined,color: Colors.blue,),),),

                  ]
                ),
                  ],
                ),
              ),
            defultTextForm(validate:(String ?value){
              if(value!.isEmpty){
                return 'Name must not be Empty';
              }
              return null;

            },
            controller:nameController ,
            label: 'Name',
            prefixIcon: Icon(Icons.person),
            ),

              SizedBox(height: 15,),
              defultTextForm(validate:(String ?value){
                if(value!.isEmpty){
                  return 'bio must not be Empty';
                }
                return null;

              },
                controller:bioController ,
                label: 'Bio',
                prefixIcon:Icon( Icons.info_outline),
              ),
              SizedBox(height: 15,),
              defultTextForm(validate:(String ?value){
                if(value!.isEmpty){
                  return 'PHONE must not be Empty';
                }
                return null;
              },
                controller: phoneController,
                label: 'Phone',
                prefixIcon:Icon( Icons.call),
              ),
            ],
          ),

        ),
      );},
    );
  }
}
