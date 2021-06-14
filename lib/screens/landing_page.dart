import 'package:flutter/material.dart';
import 'package:project_zora/services/authentication_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softWork,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: ListView(
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(170)),
              Center(
                  child: Text(
                "I'm here to",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(45, 55, 72, 0.5)),
              )),
              Padding(padding: const EdgeInsets.all(10)),
              Container(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        // As you said you don't need elevation. I'm returning 0 in both case
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return 0;
                          }
                          return 0; // Defer to the widget's default.
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(vanillaBaby)),
                  onPressed: () {
                    // Not yet implemented
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(10)),
                      Expanded(
                          child:
                              Image.asset('images/merchant_illustration.png')),
                      Expanded(
                          child: Text("Browse Products (Shopper)",
                              style: TextStyle(fontSize: 14, color: fontType)))
                    ],
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(15)),
              Container(
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return 0;
                          }
                          return 0; // Defer to the widget's default.
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(vanillaBaby)),
                  onPressed: () async {
                    await context.read<AuthenticationService>().signOut();
                    Navigator.pushNamed(context, "/authenticationPage");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(10)),
                      Expanded(
                          child:
                              Image.asset('images/shopper_illustration.png')),
                      Expanded(
                          child: Text("List Products (Merchant)",
                              style: TextStyle(fontSize: 14, color: fontType)))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
