import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../main.dart';



class AuthProvider extends ChangeNotifier {

  //login in screen
  TextEditingController user_login_email = TextEditingController();
  TextEditingController user_login_password = TextEditingController();
  bool hiden_password = true ;
  String errorTEXT = '';
  String emailErrors = 'sads';
  FaIcon hiden_icon =  FaIcon(FontAwesomeIcons.eyeSlash);

  List fialed = [];

  //singin up screen
  TextEditingController user_signup_name = TextEditingController();
  TextEditingController user_signup_email = TextEditingController();
  TextEditingController user_signup_password = TextEditingController();
  List newu = [];

  /////
  var data =userData!.get('loggedUser');

  void kok (){
    user_login_email.clear();
    user_login_password.clear();
    user_signup_name.clear();
    user_signup_email.clear();
    user_signup_password.clear();
    notifyListeners();
  }


  //hive
  putUserInHive() async{
    await  openHiveBox('muhannad');
    await userData!.put('loggedUser' , {'id' : '${this.newu[0]['user']['id']}',
    'name' :'${this.newu[0]['user']['name']}',
    'email' : '${this.newu[0]['user']['email']}',
      'token' : '${this.newu[0]['token']}'
    });
    this.data = userData!.get('loggedUser');
    
    notifyListeners();
  }

  firstOpen() async{
    await  openHiveBox('muhannad');
    await userData!.put('open', 1);
    notifyListeners();
  }


   
  

  // input errors

  hidenPassword(){
    if(this.hiden_password == true){
      this.hiden_password = false;
      this.hiden_icon = FaIcon(FontAwesomeIcons.eye);
    }else if(this.hiden_password == false){
      this.hiden_password = true;
      this.hiden_icon = FaIcon(FontAwesomeIcons.eyeSlash) ;
    }
    notifyListeners();
  }

  wrongEmail(val){
   if (!val.contains('gmail.com')) {
     this.emailErrors = 'wrong Email Syntex';
   } else if(!val.contains('@')) {
     this.emailErrors = 'you probably put ( @ )';
   }else{
    this.emailErrors = '';
   }
   notifyListeners();
  }

  changeInput(val){
    if(val.contains(' ')){
      this.errorTEXT = 'You can not user space in password';
    }else if(val.contains('wrong')){
      this.errorTEXT = 'wrong passwrod or email check please';
      notifyListeners();
    }
    else{
      this.errorTEXT = '';
    }
    notifyListeners();
  }




  //login nand register deportment

  newUser() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/login/token');

    var request = await http.post(route,
        body: convert.jsonEncode(<String,dynamic>{
          'name' : '${this.user_signup_name.text}',
          'email' : '${this.user_signup_email.text}',
          'password' : '${this.user_signup_password.text}',
        }),
        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
        'Accept':'application/json' }
    );
    if(request.statusCode == 200){
      return  convert.jsonDecode(request.body);
    }else{
      return 'bad request ${request.statusCode}';
    }


  }


  userLogin() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/login/user/token');

    var request = await http.post(route,
        body: convert.jsonEncode(<String,dynamic>{

          'email' : '${this.user_login_email.text}',
          'password' : '${this.user_login_password.text}',
        }),
        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' }
    );
    if(request.statusCode == 200){
      return  convert.jsonDecode(request.body);
    }else{
      return this.fialed.add('44');
    }

  }

  logout() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/remove/token');

    var request = await http.post(route,

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

  //buging and solving
   

}