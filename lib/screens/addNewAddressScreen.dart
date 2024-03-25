import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/addressesProvider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/screens/profileScreen.dart';

import '../widgets/inpotTextfield.dart';

class NewAddressScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final addressProvider = Provider.of<AddressesProvider>(context);

    final homeProvider = Provider.of<HomePrvider>(context);
    return Scaffold(
      body: Container(
        child: ListView(

          children: [
            ListView(
            shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Please, Fill all fileds with your information' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold ),),
                ),
                 Flexible(
                   child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex:1,
                          child: CostumNonTextFormFiled(
                            hintText: 'FirstName...',
                            contol: addressProvider.loc_first_name ,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CostumNonTextFormFiled(
                            hintText: 'Last Name...',
                            contol: addressProvider.loc_last_name ,
                          ),
                        ),
                      ],
                    ),
                 ),
                Expanded(
                  child: CostumNonTextFormFiled(
                    hintText: 'Contry...',
                    contol: addressProvider.loc_Contry ,
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CostumNonTextFormFiled(
                          hintText: 'city...',
                          contol: addressProvider.loc_city ,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CostumNonTextFormFiled(
                          hintText: 'state...',
                          contol: addressProvider.loc_state ,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CostumNonTextFormFiled(
                    hintText: 'Line1...',
                    contol: addressProvider.loc_line1 ,
                  ),
                ),
                Expanded(
                  child: CostumNonTextFormFiled(
                    hintText: 'Line2...',
                    contol: addressProvider.loc_line2 ,
                  ),
                ),
                Expanded(
                  child: CostumNonTextFormFiled(
                    hintText: 'zip_code...',
                    contol: addressProvider.loc_zip_code ,
                  ),
                ),
              ]
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: homeProvider.bas,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextButton(
                    onPressed: ()async{
                     await Provider.of<AddressesProvider>(context , listen: false).addNewAddress();
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfileScreen()),
                       ModalRoute.withName('/')

                     );
                    },
                    child: Text('Complet it' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white )),
                  ),
                ),
                SizedBox(width: 10,)
              ],
            )
          ],
        ),
      )
    );
  }
}

