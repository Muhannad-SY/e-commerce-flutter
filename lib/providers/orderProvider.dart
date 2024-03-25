import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

import '../main.dart';
import 'cartProvider.dart';

class OrderProvider extends ChangeNotifier{

  var data = userData!.get('loggedUser');

  List allOreders = [];

  List newOrder = [];

  List allOrdersDetials = [];

  int? locationId ;

  var crruntOption ;

  int? orderId;

  int? get_details_order_id;

  List<bool> totVisibilityList = [];


  bool tot = false;

  //adding and changing

  fetchOrderIdForDeails(val){
    this.get_details_order_id = val;
    notifyListeners();
  }

  // void changeTileVisibility(int tileIndex) {
  //   totVisibilityList[tileIndex] = !totVisibilityList[tileIndex];
  //   notifyListeners();
  // }




  chnageRadioGroup(val){
    this.crruntOption = val;
    notifyListeners();
  }


  // fetching data from api
  getAllordersDetiles() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/order/details/${this.get_details_order_id}');

    var request = await http.get(route,

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200) {
      this.allOrdersDetials.clear();
      this.allOrdersDetials.addAll([convert.jsonDecode(request.body)]);
      print(request.body);
      notifyListeners();
    }else{
      print('fialed${request.body}');
    }

  }


  getAllorders() async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/user/order/${this.data['id']}');

    var request = await http.get(route,

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200) {
      this.allOreders.clear();
      this.allOreders.addAll([convert.jsonDecode(request.body)]);
      notifyListeners();
    }else{
      print('fialed');
    }

  }


  createNewOrder(Decimal total , int id) async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/new/order');

    var request = await http.post(route,
        body: convert.jsonEncode(<String,dynamic>{
          "total" : "$total",
          "shipping__addresses_id" : id ,
          "user_id" : this.data?['id'],

        }),

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200) {
      this.newOrder.clear();
      this.newOrder.addAll([convert.jsonDecode(request.body)]);
      print('the new order');
      this.orderId =this.newOrder[0]['id'];
      notifyListeners();
    }else{
      print('fialed');
    }

  }



  addDetilsForOrder(int order_id , int product_id , Decimal price , int quantity) async{

    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/add/product/order');

    var request = await http.post(route,
        body: convert.jsonEncode(<String,dynamic>{
          "quantity" : quantity,
          "price" : price ,
          "order_id" : order_id,
          "product_id" : product_id,
        }),

        headers: <String,String>
        { 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json' ,
          'Authorization' : 'Bearer ${data?['token']}' }
    );
    if(request.statusCode == 200) {
      print('the order made seccassfly 100001');

    }else{
      print('fialed');
    }

  }

}