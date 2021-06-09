import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/services/database_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/loading.dart';
import 'package:project_zora/shared/picture_upload.dart';
import 'package:provider/provider.dart';

class RegistrationProfilePic extends StatefulWidget {
  RegistrationProfilePic({Key key}) : super(key: key);

  @override
  _RegistrationProfilePicState createState() => _RegistrationProfilePicState();
}

class _RegistrationProfilePicState extends State<RegistrationProfilePic> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();

  String defaultImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/project-zora.appspot.com/o/default_profile_pic.png?alt=media&token=6f5ef5c8-1b93-40f8-b1df-9525baf2385a";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Map args = ModalRoute.of(context).settings.arguments;
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
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
                    ),
                    Padding(padding: const EdgeInsets.all(15)),
                    Text(
                      "ADDRESS",
                      style: TextStyle(
                        color: grey,
                        fontSize: 12,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(5)),
                    TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a valid address";
                          }
                          return null;
                        },
                        decoration: registrationInputDecoration),
                    Padding(padding: const EdgeInsets.only(top: 60)),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (_formKey.currentState.validate()) {
                            print(firebaseUser.uid);
                            await DatabaseService(uid: firebaseUser.uid)
                                .updateMerchantData(
                                    args["shopName"],
                                    args["emailAddress"],
                                    args["phoneNumber"],
                                    addressController.text.trim(),
                                    defaultImageUrl);
                          }

                          setState(() {
                            loading = false;
                          });
                          Navigator.pushNamed(
                              context, "/completeMerchantRegistration");
                        },
                        child: Text("Next"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
