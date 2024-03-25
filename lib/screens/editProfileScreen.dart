 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/profileProvider.dart';

import '../widgets/inpotTextfield.dart';

class EditProfileScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    HomePrvider homeProvider = Provider.of<HomePrvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(7),
          child: ListView(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Text('name' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold ,  ),),
                  EditProfileTextField(
                    contol: profileProvider.edit_name,
                  ),
                  Text('email' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold ,  ),),
                  EditProfileTextField(
                    contol: profileProvider.edit_email,
                  ),
                  Text('password' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold ,  ),),
    
                  EditProfileTextField(
                    contol: profileProvider.edit_password,
                    hintText: 'Enter New Password',
                  ),
                  (profileProvider.editErrors.isEmpty)? SizedBox() : Text(profileProvider.editErrors.toString() ,
                   style:  TextStyle(color: Colors.red , fontSize: 15),),
                  SizedBox(height: 10,),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                      color: homeProvider.bas,
                      borderRadius: BorderRadius.circular(10)
                      
                    ),
                    child: TextButton(onPressed: () async{
                      profileProvider.editErrors = '';
                       Provider.of<ProfileProvider>(context , listen: false).editProfilErrors();
                     if (profileProvider.editErrors.isEmpty) {
                       await Provider.of<ProfileProvider>(context , listen: false).updateProfile();
                       Navigator.of(context).pop();
                       
                     }
                    } , child: Text('Edit' , style: TextStyle(color: Colors.white , fontSize: 20),),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}