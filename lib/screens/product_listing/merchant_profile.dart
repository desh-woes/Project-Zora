import 'package:flutter/material.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/services/authentication_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/profile_pic.dart';
import 'package:provider/provider.dart';

class MerchantProfile extends StatelessWidget {

  final MerchantData merchantData;
  MerchantProfile({this.merchantData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.only(left: 15.0)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My shop",
                    style: TextStyle(
                        fontSize: 24,
                        color: fontType,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  ProfilePic(
                    imagePath: merchantData.profilePictureUrl,
                  )
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 15.0))
          ],
        ),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
        child: ListView(
          children: <Widget>[
            Text(
              "My Products",
              style: TextStyle(
                color: fontType,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.check),
        backgroundColor: thotBlue,
        onPressed: () async {
          // TODO: Implement navigation to the add products page
          await context.read<AuthenticationService>().signOut();
          print("Pressed");
        },
      ),
    );
  }
}
