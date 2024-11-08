import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/Login_Screen/Cubit/State-Login.dart';
import 'package:social_media/Network/Local/Cache_helper.dart';
import 'package:social_media/home_Layout/home_Layout.dart';
import '../Components/Components(tools).dart';
import '../Register_Screen/Register-Screen.dart';
import 'Cubit/Cubit-Login.dart';

class LoginScreen extends StatelessWidget{
  var mailController=TextEditingController();
  var passController=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  
  Widget build(BuildContext context) {

   return BlocProvider(
    
     create: (BuildContext context) =>loginCubit(),
     child: BlocConsumer<loginCubit,loginState>(
       listener:(context,state){
         if(state is SuccessLoginState){
           CacheHelper.saveData(Key: "uId", value: state.uId).then((value){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home_Layout()));
           });
         }
       } ,
       builder: (context,state)=>Scaffold(

         appBar: AppBar(
         ),
         body:Center(
           child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Form(
                 key: formkey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20,),
                     Text('LOGIN',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                     SizedBox(height: 20,),
                     Text('login now to browse with frinds',style: TextStyle(fontSize: 20,color:Colors.black12 ),),
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

                     defultTextForm(
                      controller:passController ,
                       validate:(String? value){
                         if(value!.isEmpty){
                           return'The Password Can\'t Empty.';
                         }} ,
  
                         
                       label: 'Password ',
                       ispassword:  loginCubit.get(context).showPassword,
                       sufixIcon:IconButton(onPressed: (){
                           loginCubit.get(context).changeIcon();
                        }, icon: loginCubit.get(context).showPassword?
                         Icon(Icons.visibility_off_outlined):
                        Icon(Icons.visibility_outlined),),
                      
                       prefixIcon: Icon(Icons.password_rounded),
                       keyboardType:TextInputType.visiblePassword,),
                     SizedBox(height: 20,),
                     ConditionalBuilder(
                       condition:true,
                       builder: (context)=>defultButton(label: 'LOGIN',defultcolor: Colors.blue, onPressed: () {
                         if(formkey.currentState!.validate()){
                           loginCubit.get(context).userlogin(email:mailController.text, password: passController.text);

                         }
                       }),
                       fallback:(context)=> Center(child: CircularProgressIndicator()),

                     ),
                     TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                     }, child: Text('Register'))
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