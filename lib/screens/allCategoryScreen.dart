import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/screens/categoryScreen.dart';

import '../widgets/bottom_nav.dart';
import '../widgets/floting_botton.dart';


class AllCategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Categorys' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
      ),
      body: Container(

        child: Padding(
          padding: const EdgeInsets.only(top:10),
          child: ListView.builder(
            itemCount:productProvider.category[0][0]['data'].length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8 , left: 8 , bottom: 10),
                child: Card(
                  // margin: EdgeInsets.only(left: 10 , right: 10 , bottom: 15),
                  child:  Stack(
                      children: [
                      Card(
                      margin: EdgeInsets.zero,
                      child: ClipRRect(
                      
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)
                          ),
                        child: Image.asset('assets/images/c5.webp' , ))
                      ),
                      Positioned(
                        
                          top: 170,
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height /  5,
                          child:Padding(
                           padding:  EdgeInsets.only(right: 23 ),
                            child: Card(
                              color: Color.fromARGB(196, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10 , top: 15),
                                    child: Text(productProvider.category[0][0]['data'][index]['name'].toString() , style: TextStyle(color: Colors.white , fontSize: 24),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10 , top: 15),
                                    child: GestureDetector(
                                      onTap: () async{
                                         await Provider.of<ProductProvider>(context , listen: false).onIdToChange(productProvider.category[0][0]['data'][index]['id']);
                                         Navigator.of(context).push(MaterialPageRoute(builder: (context)  => CategoryScreen()));
                                      },
                                      child: Icon(Icons.arrow_right_outlined  ,color: Colors.white, size: 40,)),
                                  )
                                ],
                              ),
                              
                            ),
                          )),
                      
                      ]
                    ),
                  
                ),
              );
            }
            )
            ),
        ),
      ),
      floatingActionButton: FlotingCustomBotton(),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: BottomNavBar(),
    );
  }
}