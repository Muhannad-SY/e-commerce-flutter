import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/favoriteProvider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/screens/productScreen.dart';

import '../providers/cartProvider.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/floting_botton.dart';


class LikedScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    final homeProvider = Provider.of<HomePrvider>(context);

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeProvider.bas,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite , size: 28,),
            SizedBox(width: 9,),
            Text('wish List' , style: TextStyle(fontSize: 25),),
            SizedBox(width: 9,),
            Icon(Icons.favorite , size: 28),
          ],
        ),
        centerTitle: true,
      ),
      body: (favoriteProvider.likedList[0].isEmpty)? Center(child: Text('no liked product')) :Container(
        child: ListView.builder(
          itemCount: favoriteProvider.likedList[0].length,
          itemBuilder: (context, index){

            var item = favoriteProvider.checkLiked[index];

            return Padding(
              padding: const EdgeInsets.only(left: 13 , right: 13 , top: 20 ),
              child: Card(
                color: Color.fromRGBO(27, 42, 93, .3),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await  Provider.of<ProductProvider>(context , listen: false).changeShowOneProductId(productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['id']);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                      },
                      child: Container(
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height /3,
                   child: Image.network(productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['image'].toString() ,

                   fit: BoxFit.cover),
                  ),
                    ),
                    Positioned(

                      right: MediaQuery.of(context).size.width / 200,
                      child: Container(
                        height: MediaQuery.of(context).size.height /3,
                        width: MediaQuery.of(context).size.width /3.5,
                        color: Color.fromRGBO(27, 42, 93, 9),
                      ),
                    ),
                    Positioned(
                      right: 8,
                        child: Container(
                          height: 60,
                            width:MediaQuery.of(context).size.width /3.8 ,
                            child: FittedBox(
                                child: Text(
                                    productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['name'].toString() ,
                                  overflow: TextOverflow.ellipsis,maxLines: 2, style: TextStyle(
                                    color: Colors.white,

                                  ),
                                )
                            )
                        )
                    ),
                    Positioned(
                      right: 15,
                        top: 50,
                        child: Container(
                          height:  MediaQuery.of(context).size.height /20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                              itemBuilder:(context , index){
                              return Icon(Icons.star , color: Colors.yellow, size: 20,);
                              }
                              ),
                        )
                    ),
                    Positioned(
                      right: 80,
                        top: 85,
                        child: Text('5.3' , style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),)
                    ),
                    Positioned(
                      bottom: 65,
                      right: 8,
                      width: MediaQuery.of(context).size.width /3.9,
                        child:Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextButton(
                            onPressed: () async{
                              Provider.of<ProductProvider>(context , listen: false).TosatMessage('Added Seccassflly');
                              await Provider.of<CartProvider>(
                                  context, listen: false).addToCart(Product(id: (cart
                                  .items.isNotEmpty) ? cart.items.last.id + 1 : 0,
                                  quantity: productProvider.quantity,
                                  price: Decimal.parse(productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['price'])  ,
                                  price2: Decimal.parse(productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['price'])  ,
                                  product_id:productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['id'],
                                  image:productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['image'].toString(),
                                  name:productProvider.product1[0][0]['product']['data'][favoriteProvider.likedList[0][index]['product_id'] - 1]['name'].toString()
                              ));
                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(Icons.shopping_cart , color: Colors.white,),
                              SizedBox(width: 5,),
                              Text('Add' , style: TextStyle(color: Colors.white),),
                            ],)
                          ),
                        )
                    ),
                    Positioned(
                      bottom: 10,
                      right: 8,
                      width: MediaQuery.of(context).size.width /3.9,
                        child:Container(
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextButton(
                            onPressed: () async{
                              await Provider.of<FavoriteProvider>(context , listen: false).removeFromApiLike(item);
                              await Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(Icons.delete , color: Colors.white,),
                              SizedBox(width: 5,),
                              Text('unLike' , style: TextStyle(color: Colors.white),),
                            ],)
                          ),
                        ) ),
                  ]
                ),
              ),
            );
          },
          // child: Text(favoriteProvider.likedList[0].toString()),
        ),
      ),
      floatingActionButton: FlotingCustomBotton(),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: BottomNavBar(),
    );
  }
}