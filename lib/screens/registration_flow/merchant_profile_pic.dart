import 'package:flutter/material.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/picture_upload.dart';

class RegistrationProfilePic extends StatefulWidget {
  RegistrationProfilePic({Key key}) : super(key: key);

  @override
  _RegistrationProfilePicState createState() => _RegistrationProfilePicState();
}

class _RegistrationProfilePicState extends State<RegistrationProfilePic> {
  final _formKey = GlobalKey<FormState>();

  String defaultImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/project-zora.appspot.com/o/default_profile_pic.png?alt=media&token=6f5ef5c8-1b93-40f8-b1df-9525baf2385a";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 30,
              height: 25,
              child: IconButton(
                iconSize: 18,
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: fontType),
              ),
            ),
            Text(
              "Back",
              style: TextStyle(fontSize: 14, color: fontType),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 25.0, right: 25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: thotBlue,
                    thickness: 2,
                  )),
                  Padding(padding: const EdgeInsets.all(3)),
                  Expanded(
                      child: Divider(
                    color: thotBlue,
                    thickness: 2,
                  )),
                  Padding(padding: const EdgeInsets.all(3)),
                  Expanded(
                      child: Divider(
                    color: thotBlue,
                    thickness: 2,
                  )),
                ],
              ),
              Padding(padding: const EdgeInsets.all(10)),
              Text(
                "Let's get to know the\nperson behind the\nshop",
                style: TextStyle(
                  color: fontType,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: const EdgeInsets.all(20)),
              ProfilePic(
                imagePath: defaultImageUrl,
                press: (String val) {
                  setState(() {
                    defaultImageUrl = val;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
