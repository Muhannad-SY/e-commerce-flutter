import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/screens/loginScreen.dart';
import 'package:sham_store/screens/productScreen.dart';

import '../main.dart';
import '../providers/authProvider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
 Widget build(BuildContext context) {
    HomePrvider homeProvider = Provider.of<HomePrvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products'),
      ),
      body: (productProvider.category.length < 0)? Center(child: CircularProgressIndicator(),)  :Padding(
        padding: const EdgeInsets.only(right: 5 , left: 5),
        child: Container(
          child: ListView.builder(
            itemCount: productProvider.category[0][0]['data'][productProvider.categoryId]['products'].length,
            itemBuilder: (context , index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    onTap: () async{
                      await  Provider.of<ProductProvider>(context , listen: false).changeShowOneProductId(productProvider.category[0][0]['data'][productProvider.categoryId]['products'][index]['id']);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                    },
                    contentPadding: EdgeInsets.all(7),
                    title: Text(productProvider.category[0][0]['data'][productProvider.categoryId]['products'][index]['name']),
                    subtitle: Text(productProvider.category[0][0]['data'][productProvider.categoryId]['products'][index]['description'] , softWrap: true,  overflow: TextOverflow.ellipsis , maxLines: 2,  ),
                    leading:Image.network( productProvider.category[0][0]['data'][productProvider.categoryId]['products'][index]['image'].toString()),
                  )
                ),
              );
            }
            ),
        ),
      ),
    );
}
}