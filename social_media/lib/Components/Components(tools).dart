import 'package:flutter/material.dart';
import '../Login_Screen/Login-Screen.dart';
import '../Network/Local/Cache_helper.dart';
///////////////////////////////defultTextForm//////////////////////////
Widget defultTextForm(
    {
      validate ,
      onChanged,
      onTab,
      sufixIcon,
      prefixIcon,
      hintText,
      sufixPressed,
      controller,
      label,
      keyboardType,
      bool ispassword=false,
    }
    )=>TextFormField(

  controller:controller,
  validator: validate,
  onTap:onTab ,
  onChanged: onChanged,
  keyboardType:keyboardType ,
  obscureText:ispassword ,
  decoration: InputDecoration(
    prefixIconColor: Colors.blue,
    suffixIcon: sufixIcon,
    prefixIcon: prefixIcon,
    label: Text(label),
    labelStyle:const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400),
    hintText: hintText,
    hintStyle:const TextStyle(backgroundColor: Colors.white10),
    border:const OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20.0)),
        borderSide:BorderSide(style: BorderStyle.solid),),

  ),
);
//////////////////////////////////defultButton/////////////////////////////////////////////
Widget defultButton({
  required label,
  required onPressed,
  defultcolor,
})=> Container(
    height: 40,
    width: double.infinity,
    decoration:const BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(20.0)),color: Colors.blue,
    ),
    child:
    TextButton(onPressed: onPressed,

      child: Text(label,style: TextStyle(color:Colors.white,fontSize: 20),),));
/////////////////////////////////////SIGNOUT////////////////////////
void signOut(context)=> CacheHelper.removeData(Key: 'uId').then((value){
  if(value){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
});