import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/cartProvider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/screens/addOrederScreen.dart';
import 'package:sham_store/screens/productScreen.dart';

import '../providers/addressesProvider.dart';


class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final homeProvider = Provider.of<HomePrvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeProvider.bas ,
        title: Text('Cart Screen' , style: TextStyle(fontSize: 23),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
    Provider.of<CartProvider>(context , listen: false).removeAllFromCart();
    },
              child: Icon(Icons.delete)),
          SizedBox(width: 10,)
        ],
      ),
        body: cart.items.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            ):Container(
              child: ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items[index];
                      return Stack(
                        children: [Card(
                          // margin: EdgeInsets.all(10),
                          child: ListTile(

                            // isThreeLine: false,
                            onTap: () async{
                              await  Provider.of<ProductProvider>(context , listen: false).changeShowOneProductId(product.product_id);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                            },
                            leading: Image.network(product.image),
                            title: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(product.name.toString() , overflow: TextOverflow.ellipsis , style: TextStyle(fontSize: 20),),
                            ),
                            subtitle: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5 , bottom: 40),
                                  child: Text('\$${product.price.toStringAsFixed(2)}' , style: TextStyle(fontSize: 25 , color: Colors.green)),
                                ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(top: 20),
                          //         child: Row(
                          //             children: [
                          //               SizedBox(width: 10,),
                          //         Text('Count:(${product.quantity})')
                          //
                          // ]
                          //         ),
                          //       )
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_shopping_cart),
                              onPressed: () async{
                                await Provider.of<CartProvider>(context, listen: false).removeFromCart(product);
                               print(cart.items[index].id);

                              },
                            ),
                          ),
                        ),
                          Positioned(
                            bottom:20,
                              right: 100,

                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap:() async{
                                          if(product.quantity != 1) {
                                            await  Provider.of<CartProvider>(
                                                context, listen: false)
                                                .changeQuantity(
                                                product, product.quantity - 1 , product.price - product.price2);
                                            // await  Provider.of<CartProvider>(context, listen: false).changePrice(product, product.price - product.price2);


                                          }
                                        },
                                          child: Icon(Icons.minimize , size: 30, )),
                                      SizedBox(height: 10,)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Text(product.quantity.toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                                  SizedBox(width: 10,),

                                  GestureDetector(
                                    onTap: () async{
                                      // await Provider.of<CartProvider>(context, listen: false).changePrice(product,);
                                      // Duration(microseconds: 1000);
                                        await Provider.of<CartProvider>(context , listen: false).changeQuantity(product, product.quantity +1  , product.price + product.price2 );




                                    },
                                      child: Icon(Icons.add , size: 30, )),
                                ],
                              )
                          ),
                        ]
                      );
                    },
                  ),

                ],
              ),
            ),
      bottomNavigationBar: cart.items.isNotEmpty
          ? BottomAppBar(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${cart.getTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text(
                    //   'ItemsCount: ${cart.getAllItemsCount().toString()}',
                    //   style: TextStyle(fontSize: 18),
                    // ),

                    ElevatedButton(
                      onPressed: () async{
                        // here just go to anather page
                       await Provider.of<AddressesProvider>(context , listen: false).getAllUserAddresses();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewOrderScreen()));
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            )
          : null
    );
  }
}