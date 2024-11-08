import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:social_media/Cubit/States.dart';
import 'package:social_media/Model/userModel.dart';

class usersScreen extends StatelessWidget {
  const usersScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    var cubit=socialCubit.get(context);
    return BlocConsumer<socialCubit, socialStates>(
      builder: (context, state) => ConditionalBuilder(
          condition: socialCubit.get(context).users!.length > 0,
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.chevron_left,size: 30,)),
              title: Text(cubit.titles[cubit.currentindex],style: TextStyle(fontWeight: FontWeight.bold),),
              // actions: [],
            ),
            body: ListView.separated(
                  itemBuilder: (context, state) =>
                      userView(socialCubit.get(context).users![state]),
                  itemCount: socialCubit.get(context).users!.length,
                  separatorBuilder: (context, state) => Container(
                    height: .5,
                    width: double.infinity,
                    color: Colors.blue,
                  ),
                ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator())),
      listener: (context, state) {},
    );
  }
}

userView(userModel model) => InkWell(
  onTap: (){},
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
