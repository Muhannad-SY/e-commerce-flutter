
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/addressesProvider.dart';
import 'package:sham_store/providers/orderProvider.dart';
import 'package:sham_store/screens/homePageScreen.dart';

import '../providers/cartProvider.dart';
import '../providers/productProvider.dart';
import 'addNewAddressScreen.dart';

class NewOrderScreen extends StatefulWidget {


  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final addresProvider = Provider.of<AddressesProvider>(context);

    final cart = Provider.of<CartProvider>(context);

    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Complete Order Information' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold),),
                ),

              ],
            ),
            (addresProvider.addressItems.isEmpty)? Center(
              child: TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewAddressScreen()));
              }, child: Text('you dont have any address please press to add one!' , style: TextStyle(color: Colors.red , ),)),
            ) : ListTile(
            onTap: (){
              Provider.of<AddressesProvider>(context , listen: false).changeVisibVal();
              // Provider.of<CartProvider>(context , listen: false).addforOder();
            },
            title: Text('press to Chosse you address')
        ),
        Visibility(
          visible: addresProvider.isvisi,
            child: Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: addresProvider.allAdresses[0].length,
                  itemBuilder:(context  , index){
                    return RadioListTile(
                      title: Text(addresProvider.allAdresses[0][index]['address_line_1'].toString()),
                        value: addresProvider.addressItems[index].toString(),
                        groupValue: orderProvider.crruntOption,
                        onChanged: (val){
                          Provider.of<OrderProvider>(context , listen: false).chnageRadioGroup(val);
                          print(orderProvider.crruntOption);
                        orderProvider.locationId =  addresProvider.allAdresses[0][index]['id'];
                        }
                    );
                  }
                  ),
            )
        ),
            SizedBox(height: 10,),
            (addresProvider.addressItems.isEmpty)?  SizedBox() :Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  width: MediaQuery.of(context).size.width /2,
                  child: TextButton(
                    onPressed: () async{
                     await Provider.of<OrderProvider>(context , listen: false).createNewOrder(cart.getTotalPrice() , orderProvider.locationId!);
                     cart.items.forEach((element) async{
                       await Provider.of<OrderProvider>(context ,listen: false).addDetilsForOrder(orderProvider.orderId!, element.product_id, element.price, element.quantity);
                       print('one');
                     });
                     await Provider.of<CartProvider>(context , listen: false).removeAllFromCart();
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePageScreen()), ModalRoute.withName('/'));
                     Provider.of<ProductProvider>(context , listen: false).TosatMessage('The Order Has Completed');
                     
                     print('pressd');


                    },
                    child: Text('Complete order' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20),),
                  ),
                ),
              ],
            )

          ]
        ),
      ),
    );
  }
}
