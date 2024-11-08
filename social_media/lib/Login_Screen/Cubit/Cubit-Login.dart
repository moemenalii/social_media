import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Login_Screen/Cubit/State-Login.dart';

class loginCubit extends Cubit<loginState>{
  loginCubit():super(InitialState());

  static loginCubit get(context)=>BlocProvider.of(context);

  bool showPassword =true;
  void changeIcon(){
    showPassword != showPassword;
    emit(cahngeIconState());
  }

void userlogin({required email,required password}){
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      emit(SuccessLoginState(value.user!.uid));
    }).catchError((onError){emit(ErorrLoginState());});
}
}