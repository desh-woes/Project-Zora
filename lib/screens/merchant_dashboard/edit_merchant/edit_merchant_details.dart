import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/services/authentication_service.dart';
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
  // Form Keys
  final _editDetailsFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  // Default phone number country
  final PhoneNumber number = PhoneNumber(isoCode: 'RW');

  // Snack bar for when information has been successfully updated
  final snackBar =
      SnackBar(content: Text('Yay! Your details have been updated!!'));

  // Show Visibility state booleans
  bool _showEditDetails = false;
  bool _showChangePassword = false;

  // Loader boolean to confirm when to show the loader widget
  bool loading = false;

  // Password text controllers
  final TextEditingController initialPasswordController =
      TextEditingController();
  final TextEditingController finalPasswordController = TextEditingController();

  // Toggle visibility icon on first password input text field
  bool _obscureText1 = true;
  bool signUpFail1 = false;

  // Toggles the password show status
  void _toggleObscureText1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  // Toggle visibility icon on second password input text field
  bool _obscureText2 = true;
  bool signUpFail2 = false;

  // Toggles the password show status
  void _toggleObscureText2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  // Toggle visibility for edit details
  void showEditDetails() {
    setState(() {
      _showEditDetails = !_showEditDetails;
      _showChangePassword = false;
    });
  }

  // Toggle visibility for changing password details
  void showChangePassword() {
    setState(() {
      _showChangePassword = !_showChangePassword;
      _showEditDetails = false;
    });
  }

  // Helper function to help set new image url
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
                    iconPath: "images/editDetails.svg",
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
                ),
                Padding(padding: const EdgeInsets.all(3)),
                EditDetailsWidget(
                  iconPath: "images/changePassword.svg",
                  displayText: "Change Password",
                  press: () => showChangePassword(),
                ),
                Visibility(
                  visible: _showChangePassword,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 25.0, right: 25.0),
                    child: Form(
                      key: _changePasswordFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "CREATE PASSWORD",
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5)),
                          TextFormField(
                            style: TextStyle(color: fontType),
                            controller: initialPasswordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter a valid password with 6 or more values";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: vanillaBaby, width: 1.5),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(color: fontType),
                                errorText: signUpFail1
                                    ? "Password does not match"
                                    : null,
                                suffixIcon: IconButton(
                                  iconSize: 18.0,
                                  icon: Icon(
                                    _obscureText1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: thotBlue,
                                  ),
                                  onPressed: _toggleObscureText1,
                                )),
                            obscureText: _obscureText1,
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          Text(
                            "CONFIRM PASSWORD",
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5)),
                          TextFormField(
                            style: TextStyle(color: fontType),
                            controller: finalPasswordController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return "Please enter a valid password with 6 or more values";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: vanillaBaby, width: 1.5),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(color: fontType),
                                errorText: signUpFail2
                                    ? "Password can't be changed"
                                    : null,
                                suffixIcon: IconButton(
                                  iconSize: 18.0,
                                  icon: Icon(
                                    _obscureText2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: thotBlue,
                                  ),
                                  onPressed: _toggleObscureText2,
                                )),
                            obscureText: _obscureText2,
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: buttonStyle,
                              onPressed: () async {
                                if (_changePasswordFormKey.currentState
                                    .validate()) {
                                  if (initialPasswordController.text.trim() !=
                                      finalPasswordController.text.trim()) {
                                    setState(() {
                                      signUpFail1 = true;
                                      signUpFail2 = false;
                                    });
                                  } else {
                                    setState(() {
                                      loading = true;
                                    });
                                    firebaseUser
                                        .updatePassword(
                                            finalPasswordController.text.trim())
                                        .then((_) {
                                      setState(() {
                                        loading = false;
                                      });
                                      showChangePassword();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }).catchError((e) {
                                      print("Password can't be changed" +
                                          e.toString());
                                      setState(() {
                                        loading = false;
                                        signUpFail1 = false;
                                        signUpFail2 = true;
                                      });
                                    });
                                  }
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
                ),
                Padding(padding: const EdgeInsets.all(3)),
                EditDetailsWidget(
                  iconPath: "images/shopper.svg",
                  displayText: "Switch to shopper",
                  press: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
                  },
                ),
                Padding(padding: const EdgeInsets.all(3)),
                EditDetailsWidget(
                  iconPath: "images/logOut.svg",
                  displayText: "Log Out",
                  press: () async {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/", ModalRoute.withName('/'));

                    await context.read<AuthenticationService>().signOut();
                  },
                ),
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
            SvgPicture.asset(
              iconPath,
              width: 14,
            ),
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
