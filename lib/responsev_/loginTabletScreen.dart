import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/authProvider.dart';
import 'package:sham_store/responsev_/signupTabletScreen.dart';
import 'package:sham_store/screens/homePageScreen.dart';

import '../providers/productProvider.dart';
import '../widgets/inpotTextfield.dart';

class TabletLoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      // appBar: AppBar(),
        body:   SafeArea(
          child: Container(
            // color: Colors.red,
            child: Row(
              children: [
                SizedBox(width: 40,),
                SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min
                    ,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/images/c3.png',
                        height: MediaQuery.of(context).size.height / 2.2,
                        width: MediaQuery.of(context).size.width /2.7,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                  width: 100,
                  endIndent: 140,
                  indent: 140,
                  color: Colors.black,
                ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height ,
                      width: currentWidth / 2.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text('Login In' , style: TextStyle(fontSize: 50 , fontWeight: FontWeight.bold),),
                          Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: CostumNonTextFormFiled(
                             contol: authProvider.user_login_email ,
                             hintText:'Email',
                             ),
                             ),
                             Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 4, 41, .8),
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                width: MediaQuery.of(context).size.width /7,
                                child: TextButton(
                                  onPressed: () async{
                                  authProvider.fialed.clear();
                                  authProvider.newu.clear();
                                  productProvider.newu.clear();
                                  var res = await Provider.of<AuthProvider>(context, listen: false).userLogin();
                                  authProvider.newu.addAll([res]);
                                  productProvider.newu.addAll([res]);
                                  print(authProvider.newu);
                               if (!authProvider.fialed.contains('44')) {
                                  
                                  if(authProvider.newu.length > 0){
                                    await Provider.of<AuthProvider>(context, listen: false).putUserInHive();
                                    await Provider.of<ProductProvider>(context, listen: false).putUserInHive();
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageScreen()));
                                    Provider.of<AuthProvider>(context, listen: false).kok();
                                  }
                                  }else{
                                  
                          Provider.of<AuthProvider>(context , listen: false).changeInput('wrong');
                                  }

                                },
                                  child: Text('Login' , style: TextStyle(color: Colors.white),),),
                              ),
                              SizedBox(width: 20,)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('You Don\'t Have Any Account?'),
                              TextButton(onPressed: (){ Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => TabletSignupScreen())
                              );
                              },
                                  child: Text('Create Account'))
                            ],
                          ),
                        ],
                      ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

