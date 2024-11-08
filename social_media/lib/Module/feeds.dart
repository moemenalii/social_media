import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:social_media/Cubit/States.dart';
import 'package:social_media/Model/post_model.dart';
var commentController =TextEditingController();
class feedsScreen extends StatelessWidget {
  const feedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userModel = socialCubit.get(context).model;
    var postModel = socialCubit.get(context).modelP;
    var cubit=socialCubit.get(context);
    return BlocConsumer<socialCubit, socialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.chevron_left,size: 30,)),
            title: Text(cubit.titles[cubit.currentindex],style: TextStyle(fontWeight: FontWeight.bold),),
            // actions: [],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 50,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1685106415~exp=1685107015~hmac=ab3c4ba0a99a71229f5d10f55ee9932a563e3b37978cffcfcc66475e1330d3a4'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'comunicate with frinds ',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  itemBuilder: (context, index) =>postItem(socialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5.0,
                  ),
                  itemCount: socialCubit.get(context).posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget postItem(PostModel? model,context,index) => Card(
        elevation: 50,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1685106415~exp=1685107015~hmac=ab3c4ba0a99a71229f5d10f55ee9932a563e3b37978cffcfcc66475e1330d3a4'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${model!.name}'),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 12,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: TextStyle(color: Colors.black26, fontSize: 10.5),
                      ),
                    ],
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: .5,
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${model.text}'),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 35.0,
              child: Wrap(
                children: [
                  MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software',
                        style: TextStyle(color: Colors.blue),
                      )),
                  MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software',
                        style: TextStyle(color: Colors.blue),
                      )),
                  MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software-development',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ),
            if (model.postImage != "")
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipRRect(
                  // elevation: 50,
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.cover,
                    height: 350,
                    width: double.infinity,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.heart_sharp,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${socialCubit.get(context).likes[index]}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment_rounded,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage('${socialCubit.get(context).model!.image}'),
                      ),
                      SizedBox(
                        width: 50.0,
                      ),

                      Text(
                        'write a comment ...',
                        style: TextStyle(color: Colors.black12),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      socialCubit.get(context).likePost(socialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.heart_sharp,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('like'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children:[
                        Icon(
                          Ionicons.share_social_sharp,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('share '),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     TextFormField(
            //       controller: commentController,
            //     ),
            //     IconButton(onPressed: (){}, icon: Icon(Ionicons.subway))
            //   ],
            // )
          ],
        ),
      );
}
