import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../main.dart';

class ProductProvider extends ChangeNotifier {
  var data = userData!.get('loggedUser');

  List newu = [];

  List product1 = [];

  List category = [];

  var categoryId;

  int? showProductId;

  List productDetails = [];

  int quantity = 1; // deat with it for cart

  int stock = 1;

  Decimal price1 = Decimal.parse("0.00");

  Decimal price2 = Decimal.parse("0.00"); // deat with it for cart

  int ratingStars = 1;

  String ratingText = '';

  List productAllReviews = [];

  List ratingStar = [];

  onIdToChange(val) {
    this.categoryId = val;
    this.categoryId--;
    notifyListeners();
  }

  //hive

  putUserInHive() async {
    await openHiveBox('muhannad');
    await userData!.put('loggedUser', {
      'id': '${this.newu[0]['user']['id']}',
      'name': '${this.newu[0]['user']['name']}',
      'email': '${this.newu[0]['user']['email']}',
      'token': '${this.newu[0]['token']}'
    });
    this.data = userData!.get('loggedUser');

    notifyListeners();
  }

  // changing and adding

  TosatMessage(String message) => Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2);

  ratingTextAndStars(int val1, String val2) {
    this.ratingStars = val1;

    this.ratingText = val2;
    notifyListeners();
  }

  addStock() {
    this.stock = this.productDetails[0][0]['stock'];
    this.price1 = Decimal.parse(this.productDetails[0][0]['price']);
    this.price2 = Decimal.parse(this.productDetails[0][0]['price']);

    notifyListeners();
  }

  changeQuantity(val) {
    if (val == 1 && this.quantity < this.stock) {
      this.quantity++;
      // Decimal a = Decimal.parse(this.price1.toString());
      this.price2 += this.price1;
      //
    } else if (this.quantity == 1 && val == 0) {
      null;
    } else if (val == 0) {
      this.quantity--;
      this.price2 -= this.price1;
    } else {
      this.quantity = this.quantity;
    }
    notifyListeners();
  }

  changeShowOneProductId(val) async {
    this.showProductId = await val;
    Duration(seconds: 1);
    notifyListeners();
  }

// fetching data from Api deportment
  firstPage() async {
    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/product');

    var request = await http.get(route, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${data?['token']}'
    });
    if (request.statusCode == 200) {
      this.product1.clear();
      this.product1.addAll([
        [convert.jsonDecode(request.body)]
      ]);
      notifyListeners();
    } else {
      this.product1.addAll(['bad request ${request.statusCode}']);
      notifyListeners();
    }
  }

  secoundPage() async {
    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/product?page=2');

    var request = await http.get(route, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${data?['token']}'
    });
    if (request.statusCode == 200) {
      return convert.jsonDecode(request.body);
      notifyListeners();
    } else {
      return 'bad request ${request.statusCode}';
    }
  }

  categoryfetch() async {
    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/get/category');

    var request = await http.get(route, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${data?['token']}'
    });
    if (request.statusCode == 200) {
      this.category.clear();
      this.category.addAll([
        [convert.jsonDecode(request.body)]
      ]);

      notifyListeners();
    } else {
      this.category.addAll(['bad request ${request.statusCode}']);
      notifyListeners();
    }
  }

  oneProdut() async {
    Uri route = Uri.parse(
        'http://10.0.2.2:8000/api/v1/get/one/product/${this.showProductId}');

    var request = await http.get(route, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${data?['token']}'
    });
    if (request.statusCode == 200) {
      this.productDetails.clear();
      this.productDetails.addAll([convert.jsonDecode(request.body)]);
      notifyListeners();
    } else {
      this.productDetails.addAll(['bad request ${request.statusCode}']);
      notifyListeners();
    }
  }

  addReviewForProduct() async {
    Uri route = Uri.parse('http://10.0.2.2:8000/api/v1/make/review');

    var request = await http.post(route,
        body: convert.jsonEncode(<String, dynamic>{
          "review": "${this.ratingText}",
          "rating": this.ratingStars,
          "user_id": data?['id'],
          "product_id": this.productDetails[0][0]['id']
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${data?['token']}'
        });
    if (request.statusCode == 200) {
    } else {
      print('fialed');
    }
  }

  getAllReviews() async {
    Uri route = Uri.parse(
        'http://10.0.2.2:8000/api/v1/get/all/review/${this.productDetails[0][0]['id']}');

    var request = await http.get(route, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${data?['token']}'
    });
    if (request.statusCode == 200) {
      this.productAllReviews.clear();
      this.productAllReviews.addAll([convert.jsonDecode(request.body)]);
      notifyListeners();
    } else {
      print('fialed');
    }
  }
}
