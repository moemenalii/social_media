import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Network/Local/Cache_helper.dart';
import 'package:social_media/home_Layout/home_Layout.dart';
import '../Components/Components(tools).dart';
import 'Cubit/Cubit-Register.dart';
import 'Cubit/State-Register.dart';

class RegisterScreen extends StatelessWidget{
  var mailController=TextEditingController();
  var passController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) =>registerCubit(),
     child: BlocConsumer<registerCubit,registerState>(
       listener:(context,state){
         if(state is SuccessCreatUserState){
           CacheHelper.saveData(Key: 'uId', value:state.uId ).then((value) {
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>home_Layout(),),(RoutePredicate)=>true);
           }).catchError((error){});
         };


       } ,
       builder: (context,state)=>Scaffold(
         resizeToAvoidBottomInset: true,
         appBar: AppBar(
         ),
         body:Center(
           child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Form(
                 key: formkey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20,),
                     Text('Register',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                     SizedBox(height: 20,),
                     Text('Register now to browse with frinds',style: TextStyle(fontSize: 20,color:Colors.black12 ),),
                     defultTextForm(controller:nameController ,
                       validate:(String? value){
                         if(value!.isEmpty){
                           return'The Name Can\'t Empty';
                         }} ,
                       label: 'Name ',
                       prefixIcon: Icon(Icons.person),
                       keyboardType:TextInputType.name,),
                     SizedBox(height: 20,),
                     defultTextForm(controller:phoneController ,
                       validate:(String? value){
                         if(value!.isEmpty){
                           return'The phone Can\'t Empty';
                         }} ,
                       label: 'phone ',
                       prefixIcon: Icon(Icons.phone),
                       keyboardType:TextInputType.phone,),
                     SizedBox(height: 20,),
                     defultTextForm(controller:mailController ,
                       validate:(String? value){
                         if(value!.isEmpty){
                           return'The Mail Can\'t Empty';
                         }} ,
                       label: 'E-Mail-Address ',
                       prefixIcon: Icon(Icons.email),
                       keyboardType:TextInputType.emailAddress,),
                     SizedBox(height: 20,),
                     defultTextForm(controller:passController ,
                       validate:(String? value){
                         if(value!.isEmpty){
                           return'The Password Can\'t Empty';
                         }} ,
                       label: 'Password ',
                       sufixIcon:Icon(Icons.remove_red_eye_outlined) ,
                       sufixPressed: (){},
                       prefixIcon: Icon(Icons.password_rounded),
                       keyboardType:TextInputType.visiblePassword,),
                     SizedBox(height: 20,),
    defultButton(label: 'REGISTER', onPressed: (){
      if(formkey.currentState!.validate())
    registerCubit.get(context).registerUser(email: mailController.text,
    password: passController.text,phone: phoneController.text,name: nameController.text);},
        defultcolor: Colors.blueAccent),
                     // ConditionalBuilder(
                     //     condition: state is SuccessCreatUserState,
                     //     builder: (context)=>defultButton(label: 'REGISTER', onPressed: (){
                     //       registerCubit.get(context).registerUser(email: mailController.text,
                     //           password: passController.text,phone: phoneController.text,name: nameController.text);
                     //     },
                     //         defultcolor: Colors.blueAccent),
                     //     fallback: (context)=>Center(child: CircularProgressIndicator()))

                   ],
                 ),
               ),
             ),
           ),
         ) ,
       ),
     ),

   );
  }

}