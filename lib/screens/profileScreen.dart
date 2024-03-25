
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/profileProvider.dart';
import 'package:sham_store/screens/allAddressesScreen.dart';
import 'package:sham_store/screens/allOrdersScreen.dart';
import 'package:sham_store/screens/editProfileScreen.dart';
import 'package:sham_store/widgets/editCustomButton.dart';

import '../main.dart';
import '../providers/addressesProvider.dart';
import '../providers/authProvider.dart';

import '../providers/localizAndthemeProvider.dart';
import '../providers/localizAndthemeProvider.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/floting_botton.dart';
import 'loginScreen.dart';


class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProfileProvider>(context , listen: false).myProfile().then((_){
      Provider.of<ProfileProvider>(context , listen: false).putEditText();
    });
    Provider.of<AddressesProvider>(context , listen: false).getAllUserAddresses();

  }
  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    SystemChangesProvider systemChangesProvider = Provider.of<SystemChangesProvider>(context);
    HomePrvider homeProvider = Provider.of<HomePrvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Profile'),
        backgroundColor: homeProvider.bas,
        actions: [
           PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(child: EditButton('Edit Profile', Icons.edit ,  () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen())); }))
           
            
          ],
        )
        ],
      ),
      body:(profileProvider.profileData.isEmpty)? Center(child: CircularProgressIndicator(),) : Container(
        child: ListView(
          children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey[400],
                      child:ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person , color: Colors.white,)),
                          title: Text(profileProvider.profileData[0]['name'] , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                          subtitle:Text(profileProvider.profileData[0]['email'] , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),) ,
                      )
                    ),
                  ),


                  SwitchListTile(

                    controlAffinity: ListTileControlAffinity.trailing,
                    title:(systemChangesProvider.lightordarkmode == true)? 
                    Text('Dark Mode' , style: TextStyle(color: Colors.black , fontSize: 23 ,fontWeight: FontWeight.bold)):
                     Text('Light Mode ' , style: TextStyle(color: Colors.black , fontSize: 23 , fontWeight: FontWeight.bold),
                     ),
                    value:(userData!.get('theme') == 'dark')?true : systemChangesProvider.lightordarkmode, 
                    onChanged: (val) async{
                      await Provider.of<SystemChangesProvider>(context , listen: false).changeAppMode(val);
                      

                    },
                  
                    ),


                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllOrdersScreen()));
                      },
                      title: Text('All Orders' , style: TextStyle(color: Colors.black , fontSize: 20 ,fontWeight: FontWeight.bold)),
                      trailing: FaIcon(FontAwesomeIcons.bookOpenReader , size: 35, color:  Colors.deepPurple[400],),
                    ),

                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddressesScreen()));
                      },
                      title: Text('My All Addresses' , style: TextStyle(color: Colors.black , fontSize: 20 ,fontWeight: FontWeight.bold)),
                      trailing: FaIcon(FontAwesomeIcons.locationDot , size: 38, color:  Colors.deepPurple[400],),
                    ),
            ListTile(
              onTap: () async{
                await  Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()) , ModalRoute.withName('/'));
                Provider.of<HomePrvider>(context , listen: false).changeActiveNav(0);
                await userData!.delete('loggedUser');
              },
              title: Text('Logout' , style: TextStyle(color: Colors.black , fontSize: 20 ,fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.logout , size: 38, color:  Colors.deepPurple,),
            ),

          ],
        ),
      ),
      floatingActionButton: FlotingCustomBotton(),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: BottomNavBar(),
    );
  }
}