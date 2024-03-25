import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:sham_store/providers/productProvider.dart';

class RatingDilogCostum extends StatelessWidget {
  const RatingDilogCostum({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return RatingDialog(

       initialRating: 1.0,
      // your app's name?
      title: Text(
        'Rating Dialog',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: const FlutterLogo(size: 100),
      
      submitButtonText: 'Submit',
      commentHint: 'Set your rating here',
      onSubmitted: (response) async{
        // int changetoint = int.parse(response.rating);
        
      await  Provider.of<ProductProvider>(context , listen: false).ratingTextAndStars(   response.rating.toInt() ,response.comment);
     
        print('rating: ${response.rating}, comment: ${response.comment}');
     
      await  Provider.of<ProductProvider>(context , listen: false).addReviewForProduct();
        

        // TODO: add your own logic

      },
    );
  }
}