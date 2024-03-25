

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../main.dart';


class ProfileProvider extends ChangeNotifier {

  
  var data = userData!.get('loggedUser');

  bool lightordarkmode = false;

  List profileData = [];

  String editErrors = '';


  TextEditingController edit_name = TextEditingController();
  TextEditingController edit_email = TextEditingController();
  TextEditingController edit_password = TextEditingController();
 // adding and changing 

 editProfilErrors(){
 if(this.edit_password.text.isEmpty){
  this.editErrors = 'You can not leave this filed empty';
  notifyListeners();
 }
//   if (condition) {
   
//  } 
   
 
 }

 putEditText(){
  this.edit_name = TextEditingController(text: this.profileData[0]['name']);
  this.edit_email =TextEditingController(text: this.profileData[0]['email']);

  notifyListeners();
 }
 // fetch data from Api
  myProfile() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/me/${this.data?['id']}');

    var request = await http.get(route,

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      this.profileData.clear();
       this.profileData.addAll([convert.jsonDecode(request.body)]) ;
       notifyListeners();
    }

  }

  updateProfile() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/update/profile/${this.data?['id']}');

    var request = await http.post(route,
    body: convert.jsonEncode(<String,dynamic>{
          'name' : '${this.edit_name.text}',
          'email' : '${this.edit_email.text}',
          'password' : '${this.edit_password.text}',
        }),

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      return  convert.jsonDecode(request.body);
    }else{
      return 'bad request ${request.statusCode}';
    }

  }
  
  
}