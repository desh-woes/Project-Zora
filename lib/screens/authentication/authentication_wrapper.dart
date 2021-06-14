import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:project_zora/screens/product_listing/merchant_landing.dart';
import 'package:provider/provider.dart';

import 'authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    // Return either home or Authenticate widget
    if (user == null) {
      return Authenticate();
    }
    return MerchantLanding(
      firebaseUser: user,
    );
    // return Container();
  }
}
