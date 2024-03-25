import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sham_store/providers/orderProvider.dart';

import '../main.dart';

part 'cartProvider.g.dart';

class CartProvider extends ChangeNotifier {


  addforOder(int order_id){

this._cartBox.clear();
notifyListeners();
  }



  final Box<Product> _cartBox = Hive.box<Product>('cart');

  List<Product> get items => _cartBox.values.toList();

  

  addToCart(Product product){
   _cartBox.add(product);
   notifyListeners();
    
  }

   removeFromCart(Product product) {
    this._cartBox.delete(product.id);
    this.items.removeWhere((element) => element.id == product.id);// Assuming Product is a HiveObject
    notifyListeners();
  }

   changeQuantity(Product product, int val , Decimal pri) {
    final int productIndex = items.indexWhere((element) => element.id == product.id);

    if (productIndex != -1) {
      final Product updatedProduct = Product(
        id: product.id,
        quantity: val, // Update the quantity with the new value
        price: pri,
        name: product.name,
        price2: product.price2,
        product_id: product.product_id,
        image: product.image,
      );

      // Update the product in the cart with the new quantity
      _cartBox.put(productIndex, updatedProduct);

      // Notify listeners to reflect the changes in the UI
      notifyListeners();
    }
  }


   changePrice(Product product , Decimal val ) {
    final int productIndex = items.indexWhere((element) => element.id == product.id);

    if (productIndex != -1) {
      final Product updatedProduct = Product(
        id: product.id,
        quantity: product.quantity,
        price:val, // Update the price with the new value
        name: product.name,
        price2: product.price2,
        product_id: product.product_id,
        image: product.image,
      );

      // Update the product in the cart with the new price
      _cartBox.put(productIndex, updatedProduct);

      // Notify listeners to reflect the changes in the UI
      notifyListeners();
    }
  }


removeAllFromCart() {
    this._cartBox.clear(); // Assuming Product is a HiveObject
    notifyListeners();
  }

  Decimal getTotalPrice() {
  Decimal total = Decimal.parse('0.0') ;
  for (Product product in _cartBox.values) {
    total += product.price;
  }
  return total;
}

// int getAllItemsCount() {
//   int itemsCount = 0 ;
//   for (Product product in _cartBox.values) {
//     itemsCount += product.quantity;
//   }
//   return itemsCount;
// }
  
}

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int quantity;
  @HiveField(2)
  final Decimal price;
  @HiveField(3)
  final int product_id;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final Decimal price2;
  @HiveField(6)
  final String name;

  Product({required this.id,
    required this.quantity,
    required this.price,
    required this.name,
    required this.price2,
    required this.product_id,
    required this.image});
  
  
}
