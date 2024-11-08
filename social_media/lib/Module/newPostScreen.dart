import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:social_media/Cubit/States.dart';

class newPostScreen extends StatelessWidget {
  const newPostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    final now = DateTime.now();
    var userModel = socialCubit.get(context).model;
    return BlocConsumer<socialCubit, socialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _postImage =socialCubit.get(context).postImage;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('New Post',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${userModel!.image}'),),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '${userModel.name}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 12,
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        GestureDetector(
                            child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 15,
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 15,
                                  color: Colors.white,
                                )),onTap: (){
                              socialCubit.get(context).getPostImage();
                        },),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'what is your mind ...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                if(_postImage != null)
                 Expanded(
                  child:Container(
                    height: 170,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      image: DecorationImage(image:FileImage(_postImage) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadiusDirectional.circular(5.0),
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        if(_postImage != null) {
                          socialCubit.get(context).createNewPostWithImage(
                              text: textController.text,
                              dateTime: now.toLocal().toString());
                        }else
                          socialCubit.get(context).createPost(
                              text: textController.text,
                              dateTime: now.toString());

                      },
                      child: Text(
                        'Add Post',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //     color: Colors.grey[200],
                //
                //   ),
                //   width: double.infinity,
                //   child: TextButton(
                //       onPressed: () {
                //         socialCubit.get(context).createNewPostWithImage(
                //             text: textController.text,
                //             dateTime: now.toLocal().toString()
                //         );
                //       },
                //       child: Text(
                //         'Add Post With Photo',
                //         style: TextStyle(color: Colors.blue, fontSize: 20),
                //       )),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
