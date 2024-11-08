import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Cubit/Cubit.dart';
import '../Cubit/States.dart';
import '../Model/userModel.dart';
import 'chatDetailsMessage.dart';
class chatsScreen extends StatelessWidget {
  const chatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(
      BuildContext context,
      ) {
    var cubit=socialCubit.get(context);
    return BlocConsumer<socialCubit, socialStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.chevron_left,size: 30,)),
          title: Text(cubit.titles[cubit.currentindex],style: TextStyle(fontWeight: FontWeight.bold),),
          // actions: [],
        ),
        body: ConditionalBuilder(
            condition: socialCubit.get(context).users!.length > 0,
            builder: (context) => ListView.separated(
              itemBuilder: (context, state) =>
                  userView(socialCubit.get(context).users![state],context),
              itemCount: socialCubit.get(context).users!.length,
              separatorBuilder: (context, state) => Container(
                height: .5,
                width: double.infinity,
                color: Colors.blue,
              ) ,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator())),
      ),
      listener: (context, state) {},
    );
  }
}

 userView(userModel model,context) => InkWell(
  onTap: (){
    Navigator.push(context,MaterialPageRoute(
        builder: (context)=>chatsDetailsMessage(user_model: model,)));
    },
  child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('${model.image}'),
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
                  Text('${model.name}'),
                  Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
        )
      ])),
);
