import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/screens/merchant_dashboard/edit_merchant/edit_merchant_details.dart';
import 'package:project_zora/services/database_service.dart';
import 'package:project_zora/shared/loading.dart';
import 'package:provider/provider.dart';

class EditMerchantLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return StreamBuilder<MerchantData>(
      stream: DatabaseService(uid: firebaseUser.uid).merchantData,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MerchantData merchantData = snapshot.data;
          return EditMerchantDetails(merchantData: merchantData);
        }
        return Loading();
      },
    );
  }
}
