import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/authProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/responsev_/signupMobileScreen.dart';
import 'package:sham_store/screens/homePageScreen.dart';

import '../widgets/inpotTextfield.dart';

class MobileLoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body:  SafeArea(
        child: ListView(
          children:[ Container(child:
             Column(

              mainAxisSize: MainAxisSize.max,

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 50,),


                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/c3.png',
                          width: MediaQuery.of(context).size.width /2,
                          ),
                        ),
                      ],
                ),
                SizedBox(height: 30,),

                    Text('Login in' , style: TextStyle(fontSize: 35 , fontWeight: FontWeight.w600 , color: Color.fromRGBO(0, 4, 41, .8)),),


                SizedBox(height: 10,),

                     Padding(
                       padding: const EdgeInsets.only(right: 3 , left: 3),
                       child: CostumNonTextFormFiled(
                            contol: authProvider.user_login_email ,
                            hintText:'Email',
                          ),
                     ),

                SizedBox(height: 5,),

                     Padding(
                       padding: const EdgeInsets.only(right: 3 , left: 3),
                       child: CostumTextFormFiled(
                              contol: authProvider.user_login_password ,
                              hid:authProvider.hiden_password ,
                            hidIcon: authProvider.hiden_icon,


                            hintText:'Password',
                            press: (){
                              Provider.of<AuthProvider>(context , listen: false).hidenPassword();
                            },
                         onChanged:  (val){

                           Provider.of<AuthProvider>(context , listen: false).changeInput(val);
                         },
                       ),
                     ),
                (authProvider.errorTEXT.isEmpty)? SizedBox(): Row(
                      children: [
                        SizedBox(width: 10,),
                        Text('${authProvider.errorTEXT}' ,style: TextStyle(color: Colors.red , fontSize: 12),),

                   ],
                 ),
                
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 4, 41, .8),
                        borderRadius: BorderRadius.circular(10)
                      ),

                      width: MediaQuery.of(context).size.width /2,
                      child: TextButton(onPressed: () async{
                        authProvider.fialed.clear();
                        productProvider.newu.clear();
                        authProvider.newu.clear();
                        var res = await Provider.of<AuthProvider>(context, listen: false).userLogin();
                        authProvider.newu.addAll([res]);
                        productProvider.newu.addAll([res]);

                        if (!authProvider.fialed.contains('44')) {
                          
                        if (authProvider.newu.length > 0 ) {
                           
                          await Provider.of<AuthProvider>(context, listen: false).putUserInHive();
                          await Provider.of<ProductProvider>(context, listen: false).putUserInHive();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageScreen()));
                          Provider.of<AuthProvider>(context, listen: false).kok();
                        
                        }
                        }else{
                          var val = 'wrong';
                          Provider.of<AuthProvider>(context , listen: false).changeInput(val);
                        
                        }

                      },
                      child: Text('Login' , style: TextStyle(color: Colors.white),
                      ),
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You Alrady Have An Account?'),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MobileSignupScreen()));
                    }, child: Text('Sign up' , style: TextStyle(color: Color.fromRGBO(0, 4, 41, .8))))
                  ],
                ),
                Divider(
                  thickness: 0,
                  indent: 70,
                  endIndent: 70,
                  color: Colors.black,
                ),
                Text('www.ShamShop.com ' , style: TextStyle(color: Colors.grey),),
            ],
            ),
          ),
          ]
        ),
      )
    );
  }
}