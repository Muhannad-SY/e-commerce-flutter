import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../main.dart';

class FavoriteProvider extends ChangeNotifier {

  var data = userData!.get('loggedUser');

  List likedList = [];

  List checkLiked = [];

  List newLike = [];

  


 // check the liked product 


 checkLikedCook(){
  this.checkLiked.clear();
  likedList[0].forEach((value) {
   this.checkLiked.addAll([ value['product_id']]) ;
  
    notifyListeners();
   });

 }

  // fetching data from Api

  getLikedProduct() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/liked/product/${this.data?['id']}');

    var request = await http.get(route,

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      this.likedList.clear();
       this.likedList.addAll([convert.jsonDecode(request.body)]) ;
      
       notifyListeners();
    }

  }



  removeFromApiLike(val) async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/unlike/${this.data?['id']}');

    var request = await http.delete(route,
    body: convert.jsonEncode(<String,dynamic>{
          'product_id' : '$val',
        
        }),

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      print('delet like from api');
       this.checkLiked.remove(val); 
       print(this.checkLiked);
      await getLikedProduct();
       notifyListeners();
    }

  }

  addLike(val) async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/add/like');

    var request = await http.post(route,
    body: convert.jsonEncode(<String,dynamic>{
          'product_id' : '$val',
          'user_id' : '${this.data?['id']}'
        
        }),

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200){
      print('add Like');
      print(convert.jsonDecode(request.body)['product_id']);
      
       this.likedList[0].add(convert.jsonDecode(request.body));
       
       print(this.checkLiked);
       notifyListeners();
    }
    return true;

  }
  
}