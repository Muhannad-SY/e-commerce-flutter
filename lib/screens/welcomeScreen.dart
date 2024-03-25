import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/responsev_/loginmobileScreen.dart';

import '../providers/authProvider.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
            child:IntroductionSlider(
              dotIndicator: DotIndicator(selectedColor: Colors.black,
              unselectedColor: Colors.black),
              items: [
              IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset('assets/images/c1.png', 
              width: MediaQuery.of(context).size.width /2.3,),
            ), //, 
            title: RichText(text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Welcome To' ,style: TextStyle(color: Colors.black )),
                TextSpan(text: '  Sham Shop' , style:GoogleFonts.phudu(color: Color.fromRGBO(0, 4, 41, .8) , fontWeight: FontWeight.w800 , fontSize: 20))
              ]
            )),
            subtitle: Text('We hope you will have a unique experience' , style: TextStyle(color: Colors.black)),
            backgroundColor: Color.fromRGBO(193, 193, 193, 1),
          ),
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset('assets/images/c2.png', 
              
              width: MediaQuery.of(context).size.width /2,
              ),
            ),
            title: Text("All Stuf Which You Need You Will Find Here" , style: TextStyle(color: Colors.black)),
            backgroundColor:Color.fromRGBO(193, 193, 193, 1),
          ),
          
            ], done: Done(child: TextButton(child: Text('DONE' , style: TextStyle(color:Colors.black  , fontSize: 17  ),), onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).firstOpen();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            }
              ), home: LoginScreen() , animationDuration: Duration(seconds: 2)  ),),
          ),
      )
        
    );
  }
}