import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/screens/merchant_dashboard/merchant_products/view_products.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/profile_pic.dart';

class MerchantProfile extends StatelessWidget {
  final MerchantData merchantData;

  MerchantProfile({@required this.merchantData});

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
                    "Shop",
                    style: TextStyle(
                        fontSize: 24,
                        color: fontType,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/editMerchantDetails",
                          arguments: merchantData.toMap());
                    },
                    child: ProfilePic(
                      imagePath: merchantData.profilePictureUrl,
                    ),
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
              "Products",
              style: TextStyle(
                color: fontType,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height / 2,
                    minWidth: double.infinity,
                    maxHeight: MediaQuery.of(context).size.height / 2),
                child: ViewProducts()),
            Padding(padding: const EdgeInsets.all(25)),
            Text(
              "Shop Details",
              style: TextStyle(
                color: fontType,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Row(
              children: <Widget>[
                SvgPicture.asset("images/business_name.svg"),
                Padding(padding: const EdgeInsets.all(10)),
                Expanded(
                    child: Text(
                  merchantData.merchantName,
                  style: detailsStyle,
                )),
                Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 5.5))
              ],
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Row(
              children: <Widget>[
                SvgPicture.asset("images/email_address.svg"),
                Padding(padding: const EdgeInsets.all(10)),
                Expanded(
                    child: Text(
                  merchantData.email,
                  style: detailsStyle,
                )),
                Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 5.5))
              ],
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Row(
              children: <Widget>[
                SvgPicture.asset("images/phone_number.svg"),
                Padding(padding: const EdgeInsets.all(10)),
                Expanded(
                    child: Text(
                  merchantData.phoneNumber,
                  style: detailsStyle,
                )),
                Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 5.5))
              ],
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Row(
              children: <Widget>[
                SvgPicture.asset("images/location.svg"),
                Padding(padding: const EdgeInsets.all(10)),
                Expanded(
                    child: Text(
                  merchantData.address,
                  style: detailsStyle,
                )),
                Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 5.5))
              ],
            ),
            Padding(padding: const EdgeInsets.all(15)),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
        child: new FloatingActionButton(
          // elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: thotBlue,
          onPressed: () async {
            Navigator.pushNamed(context, "/addProduct");
          },
        ),
      ),
    );
  }
}
