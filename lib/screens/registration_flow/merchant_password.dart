import 'package:flutter/material.dart';
import 'package:project_zora/shared/constants.dart';

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

  bool _obscureText = true;
  bool loginFail = false;

  // Toggles the password show status
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscureText2 = true;
  bool loginFail2 = false;

  // Toggles the password show status
  void _toggleObscureText2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

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
                    text: "You'll use this to log in with your shop\nemail ",
                    style: TextStyle(
                      fontSize: 16,
                      color: fontType,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "janesmagichands@gmail.com",
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
                    return "Please enter a valid password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: vanillaBaby, width: 1.5),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: fontType),
                    errorText: loginFail2
                        ? "Incorrect email or password. Could not sign in."
                        : null,
                    suffixIcon: IconButton(
                      iconSize: 18.0,
                      icon: Icon(
                        _obscureText2 ? Icons.visibility : Icons.visibility_off,
                        color: thotBlue,
                      ),
                      onPressed: _toggleObscureText2,
                    )),
                obscureText: _obscureText2,
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
                  if (value.isEmpty) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: vanillaBaby, width: 1.5),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: fontType),
                    errorText: loginFail
                        ? "Incorrect email or password. Could not sign in."
                        : null,
                    suffixIcon: IconButton(
                      iconSize: 18.0,
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: thotBlue,
                      ),
                      onPressed: _toggleObscureText,
                    )),
                obscureText: _obscureText,
              ),
              Padding(padding: const EdgeInsets.all(60)),
              Container(
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pushNamed(context, "/registrationProfilePic");
                    }
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
