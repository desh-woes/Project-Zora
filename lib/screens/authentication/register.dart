import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key key, @required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
        child: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(30)),
            Center(
              child: RichText(
                text: TextSpan(
                    text: "Back",
                    style: TextStyle(
                        color: Color(0xFF402D3748),
                        decoration: TextDecoration.underline,
                        fontSize: 14),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Design decision to pop back to main route.
                        Navigator.pop(context);
                      }),
              ),
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Image.asset(
              "images/merchant_illustration_register.png",
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Padding(padding: const EdgeInsets.all(35)),
            Text(
              "Welcome!",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: fontType),
            ),
            Text(
              "Let’s get you registered to the \nmarketplace",
              style: TextStyle(fontSize: 16, color: fontType),
            ),
            Padding(padding: const EdgeInsets.all(30)),
            Container(
              height: 50,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/registrationMerchantInformation");
                },
                child: Text("Sign up with Email"),
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Already have an account?\n",
                    style: TextStyle(
                      color: fontType,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Sign in",
                          style: TextStyle(
                              color: thotBlue,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => widget.toggleView())
                    ]),
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
          ],
        ),
      ),
    );
  }
}
