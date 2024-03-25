import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/addressesProvider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/screens/addNewAddressScreen.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Provider.of<AddressesProvider>(context , listen: false).getAllUserAddresses();

  }
  @override
  Widget build(BuildContext context) {
    
    final addressesProvider = Provider.of<AddressesProvider>(context);

    final homeProvider = Provider.of<HomePrvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Adresses' , style: TextStyle(fontSize: 22),),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewAddressScreen()));
              },
              child: Icon(Icons.add_location_alt , color: Colors.white,))
        ],
      ),
      body: (addressesProvider.allAdresses[0].isEmpty)? Center(child: Text('You Dont Have Addresses'),) : Container(
        child: Container(
          color: Colors.grey[200],

          child: ListView.builder(
            itemCount: addressesProvider.allAdresses[0].length,
              itemBuilder: (context , index){
            return Padding(
              padding: const EdgeInsets.only(left: 5 , right: 5 , bottom: 10 , top: 10),
              child:  Card(
                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(15),
                      //set border radius more than 50% of height and width to make circle
                    ),
                  elevation: 4,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(Icons.location_on , color: Colors.deepPurple[400], size: 30,),
                          ),


                        ],
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                                Text('Firstname: ${addressesProvider.allAdresses[0][index]['first_name']}'  , overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 18) ),
                                SizedBox(height: 5,),
                                Text('Lastname: ${addressesProvider.allAdresses[0][index]['last_name']}' , overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 18 )),
                            SizedBox(height: 5,),

                            Text('Address: ${addressesProvider.allAdresses[0][index]['state'] +'.'+ addressesProvider.allAdresses[0][index]['city'] +'.' +  addressesProvider.allAdresses[0][index]['country']}' , maxLines: 2 ,style:TextStyle(fontSize: 18 ,color:Colors.deepPurple[400])),
                            SizedBox(height: 5,),

                            Text('Street name: ${addressesProvider.allAdresses[0][index]['address_line_1']}' , maxLines: 2, style:TextStyle(fontSize: 18 ,color: Colors.deepPurple[400])),
                            SizedBox(height: 5,),

                            Text('Zip_Code: ${addressesProvider.allAdresses[0][index]['zip_code']}' , style:TextStyle(fontSize: 18 )),



                          ],
                        ),
                      )
                    ],
                  )
                ),

            );
          }
          ),
        ),
      ),
    );
  }
}
