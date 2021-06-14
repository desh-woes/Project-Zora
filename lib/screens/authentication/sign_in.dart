import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/services/authentication_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/loading.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({@required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  // State booleans
  bool _obscureText = true;
  bool loginFail = false;
  bool loading = false;

  // Form Text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Toggles the password show status
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(30)),
                    Text(
                      "Welcome Back!\nLog in to continue",
                      style: TextStyle(
                        color: fontType,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(25)),
                    TextFormField(
                      style: TextStyle(color: fontType),
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty || !value.contains("@")) {
                          return "Please enter a valid email address";
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
                          labelText: "Email",
                          labelStyle: TextStyle(color: fontType),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                    Padding(padding: const EdgeInsets.all(15)),
                    TextFormField(
                      style: TextStyle(color: fontType),
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a valid password";
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
                          errorText: loginFail
                              ? "Incorrect email or password. Could not sign in."
                              : null,
                          suffixIcon: IconButton(
                            iconSize: 18.0,
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: thotBlue,
                            ),
                            onPressed: _toggleObscureText,
                          )),
                      obscureText: _obscureText,
                    ),
                    Padding(padding: const EdgeInsets.all(20)),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // Display loader while firebase sign up action is happening
                            setState(() {
                              loading = true;
                            });

                            dynamic result = await context
                                .read<AuthenticationService>()
                                .signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                            if (result == null) {
                              setState(() {
                                loginFail = true;
                                loading = false;
                              });
                            } else {
                              Navigator.pushNamed(
                                  context, "/authenticationPage");
                            }
                          }
                        },
                        child: Text("Log in"),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(12)),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Forgot your password?",
                            style: TextStyle(
                                color: thotBlue,
                                decoration: TextDecoration.underline,
                                fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: Implement "forgot password"
                                // Not implemented yet;
                              }),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(25)),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Don't have an account yet?\n",
                            style: TextStyle(
                              color: fontType,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Register to get started",
                                  style: TextStyle(
                                      color: thotBlue,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => widget.toggleView())
                            ]),
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
