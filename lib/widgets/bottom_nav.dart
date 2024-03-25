import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/screens/allCategoryScreen.dart';
import 'package:sham_store/screens/homePageScreen.dart';
import 'package:sham_store/screens/likedScreen.dart';
import 'package:sham_store/screens/profileScreen.dart';

import '../providers/homeProvider.dart';

class BottomNavBar extends StatelessWidget {

IconData? _icons;
  @override
  Widget build(BuildContext context) {
     HomePrvider homeProvider = Provider.of<HomePrvider>(context);
    return AnimatedBottomNavigationBar(
      
      icons: homeProvider.bottom_nav_icons,
      backgroundColor:Color.fromRGBO(0, 4, 41, .6) ,
      activeColor: Colors.grey[300],
      iconSize: 35,
      inactiveColor: Colors.black,
      activeIndex: homeProvider.active_nav,
      gapLocation: GapLocation.center,
      
      onTap: (val){
        Provider.of<HomePrvider>(context , listen: false).changeActiveNav(val); 
       switch(val){
          case 0 :
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageScreen()));
          break;
          case 1 :
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LikedScreen()));
          break;
          case 2:
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AllCategoryScreen()));
          break;
          case 3:
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen()));
          break;
        }
      },
    );
  }
}