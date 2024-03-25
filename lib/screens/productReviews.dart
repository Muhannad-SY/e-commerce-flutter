import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/widgets/customRatingDilog.dart';

class ProductReviewScreen extends StatefulWidget {
 

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context,listen: false).getAllReviews();
  }
  @override
  Widget build(BuildContext context) {
    HomePrvider homeProvider = Provider.of<HomePrvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeProvider.bas,
        centerTitle: true,
        title: Text('Product Reviews' , style: TextStyle(color: Colors.white),),
        leading: GestureDetector(
          onTap:() {
            productProvider.productAllReviews.clear();
            Navigator.of(context).pop();
          },
          child :Icon(Icons.arrow_back , color: Colors.white,)),
      ),

      body: (productProvider.productDetails.isEmpty)? Center(child: CircularProgressIndicator(),) :Container(
        child: ListView.builder(
          itemCount: productProvider.productDetails[0][0]['reviews'].length,
          itemBuilder:(context , index){
            return Card(

              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productProvider.productDetails[0][0]['reviews'][index]['rating'],
                        itemBuilder: (context , index){
                          return Icon(Icons.star_rate , color: Colors.yellow, size: 30,);
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15 , top: 5 , bottom: 8),
                      child: Text(productProvider.productDetails[0][0]['reviews'][index]['review'].toString() , style: TextStyle(fontSize: 23),),
                    )
                  ],
                ),
              ),
            );
          } 
        ),
      ),




      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => RatingDilogCostum(),);},
      child: Icon(Icons.add)
    ),
    );
  }
}