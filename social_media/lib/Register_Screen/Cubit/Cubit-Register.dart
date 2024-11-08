import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/userModel.dart';
import '../../Network/Local/Cache_helper.dart';
import 'State-Register.dart';

class registerCubit extends Cubit<registerState> {
  registerCubit() : super(InitialState()) {}

  static registerCubit get(context) => BlocProvider.of(context);

  void registerUser(
      {required email, required password, phone, name, isEmailVerified}) {
    emit(LoadingRegisteState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      var uId =CacheHelper.saveData(Key: 'uId', value: value.user!.uid);
      print(value.user!.uid);
      CreateUser(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
        isEmailVerified: isEmailVerified,
      );
    }).catchError((error) {
      emit(ErorrRegisterState(error));
      print('error${error}');
    });
  }

  void CreateUser({
    required email,
    required name,
    required phone,
    required uId,
    required isEmailVerified,
    image,
  }) {
    userModel model = userModel(

        name: name,
        phone: phone,
        email: email,
        uId: uId,
        isEmailVerified: isEmailVerified,
        bio: 'I\'m Mobile developer',
        image:
            'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1685106415~exp=1685107015~hmac=ab3c4ba0a99a71229f5d10f55ee9932a563e3b37978cffcfcc66475e1330d3a4',
        cover:
            'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1685106415~exp=1685107015~hmac=ab3c4ba0a99a71229f5d10f55ee9932a563e3b37978cffcfcc66475e1330d3a4');

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SuccessCreatUserState(uId));
    }).catchError((error) {
      print('error${error.toString()}');
      emit(ErorrCreatUserState(error));
    });
  }
}
