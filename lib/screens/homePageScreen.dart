


import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/favoriteProvider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/screens/allCategoryScreen.dart';
import 'package:sham_store/screens/categoryScreen.dart';
import 'package:sham_store/screens/loginScreen.dart';
import 'package:sham_store/screens/productScreen.dart';
import 'package:sham_store/widgets/bottom_nav.dart';

import '../main.dart';
import '../providers/authProvider.dart';
import '../providers/cartProvider.dart';
import '../widgets/floting_botton.dart';


class HomePageScreen extends StatefulWidget {

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context , listen: false).firstPage();
    Provider.of<ProductProvider>(context , listen: false).categoryfetch();
    Provider.of<FavoriteProvider>(context , listen: false).getLikedProduct().then((_){
      Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
    });
    
  }
  @override
  Widget build(BuildContext context) {

    HomePrvider homeProvider = Provider.of<HomePrvider>(context);

    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    final cart = Provider.of<CartProvider>(context);


    return  Scaffold(
        appBar: AppBar(
         
          backgroundColor: homeProvider.bas,

          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false).TosatMessage('Will Open in Next Verison');
              },
             icon: Icon(Icons.search, color: Colors.white, size: 35,) )
          ],
        ),

        body: (productProvider.product1.isEmpty )? Center(  child: CircularProgressIndicator()) : ( productProvider.category.isEmpty)? Center(  child: CircularProgressIndicator())
         :Container(
          padding: EdgeInsets.all(7),
          color:  Colors.grey[200],
          child: RefreshIndicator(
            onRefresh:() async{

             await  Future.delayed(Duration(seconds: 1));

             await   Provider.of<ProductProvider>(context , listen: false).firstPage();
             await  Provider.of<ProductProvider>(context , listen: false).categoryfetch();
             await Provider.of<FavoriteProvider>(context , listen: false).getLikedProduct().then((_) async{
               await  Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
             });
            }, 
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children:<Widget>[ 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(width: 5,),
                    Text('Categorys' ,
                     style: TextStyle(
                      color: Colors.cyan[400] ,
                       fontSize: 25 ,
                        fontWeight: FontWeight.bold),
                    ),
                    ],
                    ),
                    TextButton(
                      onPressed: (){
                        Provider.of<HomePrvider>(context , listen: false).changeActiveNav(2);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AllCategoryScreen()));
                      },
                     child: Text('All Category' , style: TextStyle(fontSize: 18),))
          
                  ],
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context , index){
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () async{
                            await Provider.of<ProductProvider>(context , listen: false).onIdToChange(productProvider.category[0][0]['data'][index]['id']);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryScreen()));
                          },
          
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 38,
                                backgroundImage: AssetImage('assets/images/c5.webp'),
                              ),
          
                              SizedBox(height: 5,),
          
                              Text(productProvider.category[0][0]['data'][index]['name'].toString() ,
                               style:  TextStyle(
                                color: Colors.black ,
                                 fontSize: 20 , 
                                 fontWeight: FontWeight.bold),
                                 )
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                
                ///product deportment
                Container(
                child:  GridView.builder(
                    shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 /3,
                        crossAxisCount: 2,
                        mainAxisExtent: 260,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 20),
                    itemCount: productProvider.product1[0][0]['product']['data'].length,
                    itemBuilder:(BuildContext context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                          onTap: () async{
                          await  Provider.of<ProductProvider>(context , listen: false).changeShowOneProductId(productProvider.product1[0][0]['product']['data'][index]['id']);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                          },
                          child: Container(
                            width: double.maxFinite,
                            child: Card(
                              color: Colors.grey[300] ,
                              child: Column(
                                    children: [
                                    SizedBox(
                                      height: 110 ,
                                      child:Image.network(productProvider.product1[0][0]['product']['data'][index]['image'].toString(),
                                       ),
                                      ),
                                 SizedBox(height: 5,),
                                 FittedBox(
                                   child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              child: Text(productProvider.product1[0][0]['product']['data'][index]['name'].toString() ,
                                               style: TextStyle(
                                                color:Colors.cyan[800] ,
                                                 fontSize: 17,
                                                 fontWeight: FontWeight.w400),
                                                 )
                                                 ),
                                             Text(productProvider.product1[0][0]['product']['data'][index]['description'].toString(),overflow: TextOverflow.ellipsis , maxLines: 2,  style: TextStyle(color:homeProvider.bas , fontSize: 10),),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 5 , top: 10),
                                              child: Text('\$${
                                                productProvider
                                                    .product1[0][0]['product']['data'][index]['price']
                                                    .toString()
                                              }',  style: TextStyle(color: Colors.green , fontSize: 20),),
                                            )
                                          ],
                                        )

                                      ],
                                                                 ),
                                 ),

                                ]
                                ),
                            ),
                          ),
                        ),
                        Positioned(child: CircleAvatar(radius: 18,),
                        right: 5,
                        top: 0,),
                        Positioned(
                          child:(favoriteProvider.checkLiked.contains(productProvider.product1[0][0]['product']['data'][index]['id']))? GestureDetector(
                            onTap: () async{
                           await Provider.of<FavoriteProvider>(context , listen: false).removeFromApiLike(productProvider.product1[0][0]['product']['data'][index]['id']);
                           await Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
                            
                          },
                            child: Icon(
                              Icons.favorite , color: Colors.red,),
                          ) 
                          : GestureDetector(
                            onTap: () async{
                              await Provider.of<FavoriteProvider>(context , listen: false).addLike(productProvider.product1[0][0]['product']['data'][index]['id']);
                             await Provider.of<FavoriteProvider>(context , listen: false).getLikedProduct();
                              await Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
                              
                            },
                            child: Icon(
                              Icons.favorite , color: Colors.white
                              ),
                          ),
                            top: 7,
                            right: 10,
                          ),
                          Positioned(
                            left: 10,
                              bottom: 10,
                              right: 8,
                              child:Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextButton(
                                    onPressed: () async{

                                      await Provider.of<CartProvider>(
                                          context, listen: false).addToCart(Product(id: (cart
                                          .items.isNotEmpty) ? cart.items.last.id + 1 : 0,
                                          quantity: productProvider.quantity,
                                          price: Decimal.parse(productProvider.product1[0][0]['product']['data'][index]['price'])  ,
                                          price2: Decimal.parse(productProvider.product1[0][0]['product']['data'][index]['price'])  ,
                                          product_id:productProvider.product1[0][0]['product']['data'][index]['id'],
                                          image:productProvider.product1[0][0]['product']['data'][index]['image'].toString(),
                                          name: productProvider.product1[0][0]['product']['data'][index]['name'].toString()
                                      ));
                                      Provider.of<ProductProvider>(context , listen: false).TosatMessage('Added Seccassflly');
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
                        ]
                      );
                  },   
                ),
              ),
              ]
            ),
          ),
        ),
        
   floatingActionButton: FlotingCustomBotton(),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: BottomNavBar(),
    );
  }
}
