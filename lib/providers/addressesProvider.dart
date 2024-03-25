import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../main.dart';

class AddressesProvider extends ChangeNotifier{

  var data = userData!.get('loggedUser');

  List allAdresses = [];

  List addressItems = [];

  bool isvisi = false;

  //adding and changing

  changeVisibVal(){
    (this.isvisi == true)? this.isvisi = false :
    (this.isvisi == false)? this.isvisi = true:
      null;
    notifyListeners();
  }

  // fields conrollers

  TextEditingController loc_first_name = TextEditingController();
  TextEditingController loc_last_name = TextEditingController();
  TextEditingController loc_line1 = TextEditingController();
  TextEditingController loc_line2 = TextEditingController();
  TextEditingController loc_Contry = TextEditingController();
  TextEditingController loc_city = TextEditingController();
  TextEditingController loc_state = TextEditingController();
  TextEditingController loc_zip_code = TextEditingController();

  // changing and adding

  putTextInFields(){
  this.loc_first_name = TextEditingController(text: '${data?['name']}');
  }



  // fetch adresses from api

  getAllUserAddresses() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/user/addresses/${data?['id']}');

    var request = await http.get(route,

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      this.addressItems.clear();
      this.allAdresses.clear();
      this.allAdresses.addAll([convert.jsonDecode(request.body)]);
      this.allAdresses[0].forEach( (item){
        this.addressItems.addAll(['${item['country'] + item['city']}']);

        notifyListeners();
      });
      print(this.addressItems);
      putTextInFields();
      notifyListeners();
    }
  }

  addNewAddress() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/new/address');

    var request = await http.post(route,

        body: convert.jsonEncode(<String,dynamic>{
          "first_name" : '${this.loc_first_name.text}',
          "last_name" : '${this.loc_last_name.text}',
          "address_line_1" : '${this.loc_line1.text}',
          "address_line_2" : '${this.loc_line2.text}',
          "country" : '${this.loc_Contry.text}',
          "city" : '${this.loc_city.text}',
          "state" : '${this.loc_state.text}',
          "zip_code" : '${this.loc_zip_code.text}',
          "user_id" : '${this.data?['id']}',
        }),

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      this.allAdresses.clear();
      getAllUserAddresses();
      print(this.allAdresses);
      notifyListeners();
    }
  }

}