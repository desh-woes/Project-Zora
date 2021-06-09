import 'package:flutter/material.dart';
import 'package:project_zora/services/authentication_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/loading.dart';
import 'package:provider/provider.dart';

class RegistrationMerchantPassword extends StatefulWidget {
  RegistrationMerchantPassword({Key key}) : super(key: key);

  @override
  _RegistrationMerchantPasswordState createState() =>
      _RegistrationMerchantPasswordState();
}

class _RegistrationMerchantPasswordState
    extends State<RegistrationMerchantPassword> {
  final TextEditingController initialPasswordController =
      TextEditingController();

  final TextEditingController finalPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscureText2 = true;
  bool signUpFail2 = false;
  bool loading = false;

  // Toggles the password show status
  void _toggleObscureText2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  bool _obscureText1 = true;
  bool signUpFail1 = false;

  // Toggles the password show status
  void _toggleObscureText1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    return loading
        ? Loading()
        : Scaffold(
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
                          color: vanillaBaby,
                          thickness: 2,
                        )),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Text(
                      "Set your password",
                      style: TextStyle(
                        color: fontType,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text:
                              "You'll use this to log in with your shop\nemail ",
                          style: TextStyle(
                            fontSize: 16,
                            color: fontType,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: args["emailAddress"],
                              style: TextStyle(
                                  color: thotBlue,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            )
                          ]),
                    ),
                    Padding(padding: const EdgeInsets.all(20)),
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: vanillaBaby, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: fontType),
                          errorText:
                              signUpFail1 ? "Password does not match" : null,
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: vanillaBaby, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: fontType),
                          errorText: signUpFail2
                              ? "Email address already exists"
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
                    Padding(padding: const EdgeInsets.only(top: 60)),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // Verify that both passwords are the same
                            if (initialPasswordController.text.trim() !=
                                finalPasswordController.text.trim()) {
                              setState(() {
                                signUpFail1 = true;
                              });
                            } else {
                              // Display loader while firebase sign up action is happening
                              setState(() {
                                loading = true;
                              });

                              dynamic result = await context
                                  .read<AuthenticationService>()
                                  .registerWithEmailAndPassword(
                                      args["shopName"],
                                      args["emailAddress"],
                                      finalPasswordController.text.trim(),
                                      args["phoneNumber"]);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  signUpFail2 = true;
                                });
                              }

                              if (result != null) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pushNamed(
                                    context, "/registrationProfilePic",
                                    arguments: args);
                              }
                            }
                          }
                        },
                        child: Text("Next"),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                  ],
                ),
              ),
            ),
          );
  }
}
