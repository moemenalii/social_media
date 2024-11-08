import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/Cubit/States.dart';
import 'package:social_media/Model/message_model.dart';
import 'package:social_media/Model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/Module/chats.dart';
import 'package:social_media/Module/feeds.dart';
import 'package:social_media/Module/newPostScreen.dart';
import 'package:social_media/Module/settings.dart';
import 'package:social_media/Module/users.dart';
import 'package:social_media/Network/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Model/post_model.dart';

class socialCubit extends Cubit<socialStates> {
  socialCubit() : super(socialInitial());
  static socialCubit get(context) => BlocProvider.of(context);

  userModel? model = userModel();
  PostModel? modelP;
  void getUserData() {
    emit(socialGetUserLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = userModel.fromjson(value.data());
      emit(socialGetUserSuccess());
    }).catchError((erorr) {
      emit(socialGetUserErorr(erorr.toString()));
    });
  }

  var currentindex = 0;
  List<String> titles = [
    'Home',
    'chats',
    'Posts',
    'users',
    'settings',
  ];

  List<Widget> screens = [
    feedsScreen(),
    chatsScreen(),
    newPostScreen(),
    usersScreen(),
    settingsScreen(),
  ];
  void changeBottom(int index) {
    if (index == 1)
      getAllUsers();
    if (index == 2)
      emit(socialNewPost());
    else {
      currentindex = index;
      emit(changeBottomNva());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(socialPickedImageSuccess());
      upLoadProfileImage();
    } else {
      print('No image selected');
      emit(socialPickedImageErorr());
    }
  }

  String ProfileImageUrl = '';
  void upLoadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        ProfileImageUrl = value;
        model!.image = value;
        emit(socialUpLoadProfileImageSuccess());
      }).catchError((error) {});
      emit(socialUpLoadProfileImageErorr());
    });
  }

  File? CoverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(socialPickedCoverSuccess());
      upLoadCoverImage();
    } else {
      print('No image selected.');
      emit(socialPickedCoverErorr());
    }
  }

  String coverImageUrl = '';
  void upLoadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        emit(socialUpLoadCoverImageSuccess());
      }).catchError((error) {});
      emit(socialUpLoadCoverImageErorr());
    });
  }

  void updateUserImage({
    name,
    phone,
    bio,
  }) {
    if (CoverImage != null) {
      upLoadCoverImage();
    } else if (profileImage != null) {
      upLoadProfileImage();
    } else if (profileImage != null && CoverImage != null) {
      upLoadProfileImage();
      upLoadCoverImage();
    } else {
      updateUser(name: name, bio: bio, phone: phone);
    }
  }

  updateUser({
    name,
    phone,
    bio,
  }) {
    userModel modelU = userModel(
        name: name,
        phone: phone,
        uId: uId,
        bio: bio,
        email: model!.email,
        image: model!.image,
        cover: model!.cover);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(modelU.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      log(error);
      emit(socialGetUserErorr(error));
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(socialPickedPostImageSuccess());
    } else {
      print('No image selected');
      emit(socialPickedPostImageErorr());
    }
  }

  String postImageUrl = '';
  void createNewPostWithImage({
    required String text,
    required String dateTime,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
        print(value);
        postImageUrl = value;
        emit(creatPostSuccessState());
      }).catchError((error) {});
      emit(creatPostErorrState());
    });
  }

  createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    print('this post is uploaded');
    PostModel modelP = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(modelP.toMap())
        .then((value) {
      emit(creatPostSuccessState());
    }).catchError((error) {
      log(error);
      emit(creatPostErorrState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(creatPostLoadingState());
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime').snapshots().listen((onData){
      onData.docs.forEach((element) {
        element.reference.collection('likes').snapshots().listen((onData){
          likes.add(onData.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
          emit(socialGetPostsSuccess());
        });
        });
    });



  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true}).then((onValue) {
      emit(socialLikePostSuccess());
    }).catchError((erorr) {
      emit(socialLikePostErorr(erorr));
    });
  }

  void commentPost(String postId, dynamic comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({'comment': comment}).then((onValue) {
      emit(socialCommentPostSuccess());
    }).catchError((erorr) {
      emit(socialCommentPostErorr(erorr));
    });
  }

  List<userModel>? users;
  void getAllUsers() {
    users = [];
    emit(socialGetAllUsersLoading());
    FirebaseFirestore.instance.collection('users').get().then((onValue) {
      onValue.docs.forEach((element) {
        if (model!.uId !=element.data()[uId] ) {
          users!.add(userModel.fromjson(element.data()));
        }

      });
      emit(socialGetAllUsersSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(socialGetAllUsersErorr(onError));
    });
  }

  void sendMessage({required dateTime, required text, required receiverId}) {
    MessageModel _model = MessageModel(
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: model!.uId,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(_model.toMap())
        .then((onValue) {
      emit(socialSendMessageSuccess());
    }).catchError((onError) {
      emit(socialSendMessageErorr(onError.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(_model.toMap())
        .then((onValue) {
      emit(socialSendMessageSuccess());
    }).catchError((onError) {
      emit(socialSendMessageErorr(onError.toString()));
    });
  }

  List<MessageModel> messages = [];
void  getAllMyMessages({required receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((onData) {
      messages=[];
      onData.docs.forEach((action) {
        messages.add(MessageModel.fromjson(action.data()));
      });
      emit(socialGetMessageSuccess());
    });
  }
}
