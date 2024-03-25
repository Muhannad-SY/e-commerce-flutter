import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/cartProvider.dart';
import 'package:sham_store/providers/favoriteProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/screens/cartScreen.dart';
import 'package:sham_store/screens/homePageScreen.dart';
import 'package:sham_store/screens/productReviews.dart';
import 'package:sham_store/widgets/customRatingDilog.dart';

import '../providers/homeProvider.dart';

class ProductDetailsScreen extends StatefulWidget {

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context , listen: false).oneProdut().then((_){
      Provider.of<ProductProvider>(context , listen:  false).addStock();
    });
     Provider.of<FavoriteProvider>(context , listen: false).getLikedProduct().then((_){
      Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
    });
    
  }
  @override
  Widget build(BuildContext context) {

    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    HomePrvider homeProvider = Provider.of<HomePrvider>(context);

    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    CartProvider cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        // backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap:(){
            Navigator.of(context).pop(MaterialPageRoute(builder: (context) => HomePageScreen()));
            productProvider.productDetails.clear();
            productProvider.quantity =1 ;
          } ,
          child: Icon(Icons.arrow_back )),
        title: Text('Product Details' , style: TextStyle(fontSize: 24),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CartScreen()));
            },
              icon: FaIcon(FontAwesomeIcons.cartShopping )
      ),
          SizedBox(width: 5,)
        ],
      ),
      body: (productProvider.productDetails.isEmpty )? Center(child: CircularProgressIndicator(),):Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
               child: Image.network(productProvider.productDetails[0][0]['image'].toString()),
              ),
              Positioned( top: 10, left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                  )),
              Positioned(
                top: 20,
                left: 20,//
                child:(favoriteProvider.checkLiked.contains(productProvider.productDetails[0][0]['id']))?  GestureDetector(
                  onTap: () async{
                    await Provider.of<FavoriteProvider>(context , listen: false).removeFromApiLike(productProvider.productDetails[0][0]['id']);
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 40,
                    color: Colors.red,
                  ),
                ) :(!favoriteProvider.checkLiked.contains(productProvider.productDetails[0][0]['id']))? GestureDetector(
                  onTap: () async{
                    await Provider.of<FavoriteProvider>(context , listen: false).addLike(productProvider.productDetails[0][0]['id']);
                    await Provider.of<FavoriteProvider>(context , listen: false).getLikedProduct();
                    await Provider.of<FavoriteProvider>(context , listen: false).checkLikedCook();
                  },
                  child: Icon(
                    Icons.favorite_border_sharp,
                    size: 40,
                    color: Colors.black54,
                  ),
                ): SizedBox(),
                )
            ],         
            ),


            ListView(
              padding: EdgeInsets.only(left: 10 , right: 10),
              shrinkWrap: true,
              children: [
                SizedBox(height: 10,),
                
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         SizedBox(height: 10,),
                         Text(
                         (productProvider.stock >= 11)? 'Available quantity (${productProvider.productDetails[0][0]['stock'].toString()})'
                         : 'Quantity is running out (${productProvider.productDetails[0][0]['stock'].toString()})'
                         , style: TextStyle(color: (productProvider.stock >= 11)? const Color.fromARGB(255, 69, 240, 74): Colors.red),)
                       ],
                     ),
                
                    Text('Product Name :' , style: TextStyle(fontSize: 15 , 
                         ), ),
                         SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(width: 7,),
                        Text(productProvider.productDetails[0][0]['name'].toString() ,
                             style: TextStyle(fontSize: 19 , 
                             color: homeProvider.bas,
                             fontWeight: FontWeight.bold),
                             ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('Description :' ,
                     style: TextStyle(fontSize: 15 , 
                     ), 
                     ),
                    SizedBox(height: 5,),
                    Text(productProvider.productDetails[0][0]['description'].toString() , 
                             style: TextStyle(fontSize: 19 , 
                             color: homeProvider.bas,
                             fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    (productProvider.productDetails[0][0]['reviews'].isEmpty)? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    
                     Row(
                       children: [
                        
                         Text('There is not Any review' , 
                         style: TextStyle(fontSize: 19),
                         ),
                         SizedBox(width: 10,),
                         Icon(Icons.error),
                       ],
                     ),
                     TextButton(onPressed: (){
                      showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => RatingDilogCostum(),
    );
                      ;
                     }, child: Text('Add Review'))
                     ]
                     ) : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                      
                         Text('Show All Reviews And Trating' , 
                         style: TextStyle(fontSize: 15),),
                        //  SizedBox(width: ,),
                         Row(
                           children: [
                             GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductReviewScreen()));
                              },
                              child: Icon(Icons.remove_red_eye_sharp , size: 30, color: Colors.amber,)),
                             SizedBox(width: 10,),
                             Text('reviews count(${productProvider.productDetails[0][0]['reviews'].length})'),
                           ],
                         )
                       ],
                     ),
                    SizedBox(height: 20,),


              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10 , right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('price:' , style: TextStyle(fontSize: 15 , 
                         )
                         ),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text(productProvider.price2.toString() ,//
                         style: TextStyle(color: const Color.fromARGB(255, 255, 191, 0) , fontSize: 24  , fontWeight: FontWeight.bold),),
                      ],
                    ),

                  //   Row(
                  //     children: [
                  //       GestureDetector(onTap: (){
                  // Provider.of<ProductProvider>(context , listen: false).changeQuantity(0);
                  //
                  //       },
                  //         child: FaIcon(FontAwesomeIcons.minus , size: 20,)),
                  //       SizedBox(width: 14,),
                  //  Text(productProvider.quantity.toString() , style: TextStyle(fontSize: 22),),
                  //  SizedBox(width: 10,),
                  //  GestureDetector(onTap: (){
                  // Provider.of<ProductProvider>(context , listen: false).changeQuantity(1);
                  //
                  //  },
                  //   child: Icon(Icons.add)),
                  //           SizedBox(width: 15,),
                  //     ],
                  //   ),
                    
                    ]
                  ),

                  SizedBox(height: 10,),

                  Card(
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(homeProvider.bas)),
                      onPressed:() async {
                        try {
                          // Read and write operations here
                          Provider.of<ProductProvider>(context, listen: false)
                              .TosatMessage('Added To Cart Seccassfly');
                          await Provider.of<CartProvider>(
                              context, listen: false).addToCart(Product(id: (cart
                              .items.isNotEmpty) ? cart.items.last.id + 1 : 0,
                            quantity: productProvider.quantity,
                            price: productProvider.price2 ,
                            price2: productProvider.price2 ,
                            product_id:productProvider.productDetails[0][0]['id'],
                            image:productProvider.productDetails[0][0]['image'].toString(),
                            name: productProvider.productDetails[0][0]['name'].toString()
                          ));
                        } catch (e, stackTrace) {
                          print('Hive operation failed: $e');
                          print('Stack Trace: $stackTrace');
                        }

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Add To Cart' , style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ), 
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}