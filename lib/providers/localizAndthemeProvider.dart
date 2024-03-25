import 'package:flutter/material.dart';

import '../main.dart';

class SystemChangesProvider extends ChangeNotifier {

  var data = userData!.get('loggedUser');

  
  var realTheme = userData!.get('theme');

  bool lightordarkmode = false;

  

  changeAppMode(value) {

    if (value == false) {
      this.lightordarkmode = false;
      changeTheme(value);
      notifyListeners();
    } else if(value == true){
      this.lightordarkmode = true;
      changeTheme(value);
      notifyListeners();
    }
    
//     (this.lightordarkmode == false)? this.lightordarkmode = true
// : 
//     (this.lightordarkmode == true)? this.lightordarkmode = false  : 
//     this.lightordarkmode = this.lightordarkmode;
    notifyListeners();
  }
 
 changeTheme(val ) async{
 
  if (val  ==   true) {
    await userData!.put( 'theme' , 'dark');
   
    this.realTheme = userData!.get('theme');
    notifyListeners();
  } else if(val == false) {
    userData!.delete('theme');
    this.realTheme = userData!.get('theme');
    
    notifyListeners();
  }
notifyListeners();
 }
  



  
}