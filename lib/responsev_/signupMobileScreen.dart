import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/authProvider.dart';
import 'package:sham_store/responsev_/loginmobileScreen.dart';
import 'package:sham_store/screens/homePageScreen.dart';

import '../providers/productProvider.dart';
import '../widgets/inpotTextfield.dart';

class MobileSignupScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        body:  SafeArea(
          child: ListView(
            children: [
              Container(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),

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

                SizedBox(height: 20,),

                Text('Sign up' , style: TextStyle(fontSize: 35 , fontWeight: FontWeight.w600),),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(right: 3 , left: 3),
                  child: CostumNonTextFormFiled(
                    contol: authProvider.user_signup_name ,
                    hintText:'Name',
                  ),
                ),

                SizedBox(height: 5,),

                Padding(
                  padding: const EdgeInsets.only(right: 3 , left: 3),
                  child: CostumNonTextFormFiled(
                    onChanged: (val){
                      Provider.of<AuthProvider>(context , listen: false).wrongEmail(val);
                    },
                    contol: authProvider.user_signup_email ,
                    hintText:'Email',
                  ),
                ),

                (authProvider.emailErrors.isEmpty)? SizedBox(): Row(
                  children: [
                    SizedBox(width: 10,),
                    Text('${authProvider.emailErrors}' ,style: TextStyle(color: Colors.red , fontSize: 15),),

                  ],
                ),

                SizedBox(height: 5,),

                Padding(
                  padding: const EdgeInsets.only(right: 3 , left: 3),
                  child: CostumTextFormFiled(
                    contol: authProvider.user_signup_password ,
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
                    Text('${authProvider.errorTEXT}' ,style: TextStyle(color: Colors.red , fontSize: 15),),

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

                        authProvider.newu.clear();
                        productProvider.newu.clear();
                         if (!authProvider.emailErrors.contains(' ')) {
                              var res = await Provider.of<AuthProvider>(context, listen: false).newUser();
                              authProvider.newu.addAll([res]);
                              productProvider.newu.addAll([res]);
                            }
                        
                        print(authProvider.newu);
                        if(authProvider.newu.length > 0){
                          await Provider.of<AuthProvider>(context, listen: false).putUserInHive();
                          await Provider.of<ProductProvider>(context, listen: false).putUserInHive();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageScreen()));
                          Provider.of<AuthProvider>(context, listen: false).kok();
                        }
                                    
                      },
                        child: Text('Sign up' ,
                        style: TextStyle(color: Colors.white),
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MobileLoginScreen()));
                    }, child: Text('Login in' ))
                  ],
                ),
                
                Divider(
                  thickness: 0,
                  indent: 70,
                  endIndent: 70,
                  color: Colors.black,
                ),

              Text('www.ShamShop.com ' ,
               style: TextStyle(color: Colors.grey),
               ),

              ],
            ),
            ),

            SizedBox(height: 10,)
            
            ]
          ),
        )
    );
  }
}