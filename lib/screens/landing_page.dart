import 'package:flutter/material.dart';
import 'package:project_zora/shared/constants.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      backgroundColor: softWork,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40.0, right: 40.0),
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: height)),
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
                  onPressed: () {
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
