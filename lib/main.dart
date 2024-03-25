import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sham_store/providers/addressesProvider.dart';
import 'package:sham_store/providers/authProvider.dart';
import 'package:sham_store/providers/cartProvider.dart';
import 'package:sham_store/providers/favoriteProvider.dart';
import 'package:sham_store/providers/homeProvider.dart';
import 'package:sham_store/providers/localizAndthemeProvider.dart';
import 'package:sham_store/providers/orderProvider.dart';
import 'package:sham_store/providers/productProvider.dart';
import 'package:sham_store/providers/profileProvider.dart';
import 'package:sham_store/screens/cartScreen.dart';
import 'package:sham_store/screens/homePageScreen.dart';
import 'package:sham_store/screens/loginScreen.dart';
import 'package:sham_store/screens/welcomeScreen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


Box? userData;
Box? cartProduct;


Future<Box> openHiveBox(String boxName) async{
  if(!Hive.isBoxOpen(boxName)){
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.deleteBoxFromDisk("cart");


  userData = await openHiveBox('muhannad');
   await Hive.openBox<Product>('cart');
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => HomePrvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => SystemChangesProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => AddressesProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),

        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder:FToastBuilder() ,
      debugShowCheckedModeBanner: false,
      title: 'Sham store',
      theme: Provider.of<SystemChangesProvider>(context).realTheme == 'dark' ? ThemeData.dark() : ThemeData.light(),
      
      home: (userData!.get('open') == null) ? WelcomeScreen() : (userData!.get('loggedUser') == null)? LoginScreen() :HomePageScreen(),
    );
  }
}



