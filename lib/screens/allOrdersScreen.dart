import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/orderProvider.dart';
import 'package:sham_store/screens/orderDetialsScreen.dart';



class AllOrdersScreen extends StatefulWidget {


  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderProvider>(context , listen: false).getAllorders();

  }
  @override
  Widget build(BuildContext context) {
    final orderPovider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Oredres' ,style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: (orderPovider.allOreders.isEmpty)? Center(child: CircularProgressIndicator(),)
          :Container(
        padding: EdgeInsets.only(right: 7 , left: 7),
        child: ListView.builder(
          itemCount: orderPovider.allOreders[0].length,
            itemBuilder: (context , index){
             var item = orderPovider.allOreders[0][index];
             // bool isvis = orderPovider.totVisibilityList[index];
             // var detil =
            return  ListTile(
                    title: Text(item['total'].toString()),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async{

                    await Provider.of<OrderProvider>(context , listen: false).fetchOrderIdForDeails(item['id']);
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsScreen()));

                    },
                  );


            }),
      )
    );
  }
}
