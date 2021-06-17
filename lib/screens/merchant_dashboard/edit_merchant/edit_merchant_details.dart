import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/services/database_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/loading.dart';
import 'package:project_zora/shared/picture_upload.dart';
import 'package:project_zora/shared/profile_pic.dart';
import 'package:provider/provider.dart';

class EditMerchantDetails extends StatefulWidget {
  final MerchantData merchantData;

  EditMerchantDetails({@required this.merchantData});

  @override
  _EditMerchantDetailsState createState() => _EditMerchantDetailsState();
}

class _EditMerchantDetailsState extends State<EditMerchantDetails> {
  final _editDetailsFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();
  final PhoneNumber number = PhoneNumber(isoCode: 'RW');
  final snackBar =
      SnackBar(content: Text('Yay! Your details have been updated!!'));

  bool _showEditDetails = false;
  bool _showChangePassword = false;
  bool loading = false;

  String profilePicUrl = defaultUrl;

  void showEditDetails() {
    setState(() {
      _showEditDetails = !_showEditDetails;
    });
  }

  void showChangePassword() {
    setState(() {
      _showChangePassword = !_showChangePassword;
    });
  }

  String setImageUrl(String newImageUrl, String oldImageUrl) {
    print("New URL: " + newImageUrl);
    print("Old URL: " + oldImageUrl);
    if (newImageUrl == null || newImageUrl == "") {
      return oldImageUrl;
    }
    return newImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Map merchantData = widget.merchantData.toMap();

    // Form Text fields
    final TextEditingController shopNameController =
        TextEditingController(text: merchantData["merchantName"]);
    final TextEditingController emailController =
        TextEditingController(text: merchantData["email"]);
    final TextEditingController phoneNumberController =
        TextEditingController(text: merchantData["phoneNumber"]);
    final TextEditingController addressController =
        TextEditingController(text: merchantData["address"]);
    final TextEditingController imageUrlController =
        TextEditingController(text: merchantData["profilePictureUrl"]);

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 25,
                    child: Align(
                      child: IconButton(
                        iconSize: 18,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios, color: fontType),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 10.0)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          merchantData["merchantName"],
                          style: TextStyle(
                              fontSize: 24,
                              color: fontType,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        ProfilePic(
                          imagePath: merchantData["profilePictureUrl"],
                        )
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 15.0))
                ],
              ),
              elevation: 0.0,
              titleSpacing: 10.0,
              centerTitle: true,
            ),
            body: ListView(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(3)),
                EditDetailsWidget(
                    iconPath: "images/business_name.svg",
                    displayText: "Edit Details",
                    press: () => showEditDetails()),
                Visibility(
                  visible: _showEditDetails,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 25.0, right: 25.0),
                    child: Form(
                      key: _editDetailsFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfilePicUpload(
                            imagePath: merchantData["profilePictureUrl"],
                            press: (String val) {
                              imageUrlController.text = val;
                            },
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          Text(
                            "SHOP NAME",
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5)),
                          TextFormField(
                            controller: shopNameController,
                            // initialValue: merchantData["merchantName"],
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your shop name";
                              }
                              return null;
                            },
                            decoration: registrationInputDecoration,
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          Text(
                            "PHONE NUMBER",
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5)),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: phoneNumberController,
                            formatInput: false,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            inputBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            inputDecoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: vanillaBaby, width: 1.5),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1.5))),
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
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
                            // initialValue: merchantData["merchantName"],
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your shop name";
                              }
                              return null;
                            },
                            decoration: registrationInputDecoration,
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: buttonStyle,
                              onPressed: () async {
                                if (_editDetailsFormKey.currentState
                                    .validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  await DatabaseService(uid: firebaseUser.uid)
                                      .addMerchantData(
                                          shopNameController.text.trim(),
                                          emailController.text.trim(),
                                          phoneNumberController.text.trim(),
                                          addressController.text.trim(),
                                          setImageUrl(
                                              imageUrlController.text.trim(),
                                              merchantData[
                                                  "profilePictureUrl"]));
                                  setState(() {
                                    loading = false;
                                  });
                                  showEditDetails();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text("Save"),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class EditDetailsWidget extends StatelessWidget {
  final String iconPath;
  final String displayText;
  final Function() press;

  const EditDetailsWidget(
      {Key key,
      @required this.iconPath,
      @required this.displayText,
      @required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        height: 50,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SvgPicture.asset(iconPath),
            Padding(padding: const EdgeInsets.all(10)),
            Expanded(
                child: Text(
              displayText,
              style: detailsStyle,
            ))
          ],
        ),
      ),
    );
  }
}
