import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orderProvider.dart';

class OrderDetailsScreen extends StatefulWidget {


  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Provider.of<OrderProvider>(context , listen: false).getAllordersDetiles();
  }
  @override
  Widget build(BuildContext context) {
    final orderPovider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Oredre Details' ,style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: (orderPovider.allOrdersDetials.isEmpty)? Center(child: CircularProgressIndicator(),):
          Container(
            child: ListView.builder(
              itemCount: orderPovider.allOrdersDetials[0].length,
              itemBuilder: (context , index){
                var item = orderPovider.allOrdersDetials[0][index];
                return Card(
                  child: ListTile(
                    title: Text('Product ${index + 1}'),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width / 10,),

                          Text('Price \$${item['price'].toString()}' , style: TextStyle(color: Colors.green , fontSize: 15),),
                          SizedBox(width: MediaQuery.of(context).size.width / 5,),
                          Text('Quantity is ${item['quantity'].toString()}' , style: TextStyle(color: Colors.red , fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                );
              },

            ),
          )
    );
  }
}
