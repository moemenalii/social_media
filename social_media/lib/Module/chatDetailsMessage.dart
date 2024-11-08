import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/Cubit/Cubit.dart';
import 'package:social_media/Model/message_model.dart';
import 'package:social_media/Model/userModel.dart';
import '../Cubit/States.dart';

class chatsDetailsMessage extends StatelessWidget {
  chatsDetailsMessage({
    Key? key,
    this.user_model,
  }) : super(key: key);
  userModel? user_model;
  var messageController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Builder(builder: (context) {
      socialCubit.get(context).getAllMyMessages(receiverId: user_model!.uId);
      return BlocConsumer<socialCubit, socialStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${user_model!.image}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${user_model!.name}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message=socialCubit.get(context).messages[index];

                              if(socialCubit.get(context).messages[index].receiverId ==user_model!.uId )
                                return buildMyMessageItem(context,message);
                              if(socialCubit.get(context).messages[index].senderId ==socialCubit.get(context).model!.uId )
                                return buildMessageItem(context,message);

                          } ,
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: socialCubit.get(context).messages.length),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message here ...',
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              socialCubit.get(context).sendMessage(dateTime: DateTime.now().toString(), text: messageController.text, receiverId:user_model!.uId );
                            },
                            child: Icon(
                              Ionicons.send_outline,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
        listener: (context, state) {},
      );
    });
  }

  buildMessageItem(context, MessageModel ?messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: 100,
        // height: 45,
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
            color: Colors.grey[300]),
        child: Center(
            child: Text(
          '${messageModel!.text}',
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }

  buildMyMessageItem(context, MessageModel ?messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        width: 100,
        // height: 45,
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
            color: Colors.blue[300]),
        child: Center(
            child: Text(
          '${messageModel!.text}',
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}
