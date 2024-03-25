import 'package:flutter/material.dart';
import 'package:sham_store/responsev_/layerBuilder.dart';
import 'package:sham_store/responsev_/loginTabletScreen.dart';

import '../responsev_/loginmobileScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(mobileBody: MobileLoginScreen() , tabletBody:TabletLoginScreen() ),
    );
  }
}
