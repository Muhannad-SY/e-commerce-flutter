import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sham_store/screens/cartScreen.dart';

class FlotingCustomBotton extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      shape: CircleBorder(),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartScreen()));
      },
      backgroundColor: Color.fromRGBO(162, 169, 174, .5),
      child: FaIcon(FontAwesomeIcons.cartShopping , size: 27,),
   );
;
  }
}