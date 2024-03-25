import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../main.dart';

class HomePrvider extends ChangeNotifier {
  List<IconData> bottom_nav_icons = [
    Icons.home,
    Icons.favorite,
    Icons.category,
    Icons.person,
    
  ];

  Color bas = Color.fromRGBO(0, 4, 41, .8);


 int active_nav = 0;

changeActiveNav(val){
  active_nav = val;
  notifyListeners();
}



}