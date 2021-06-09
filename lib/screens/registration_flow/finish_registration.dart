import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/shared/constants.dart';

class CompleteRegistration extends StatelessWidget {
  const CompleteRegistration({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thotBlue,
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 25.0, right: 25.0),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "images/confetti.png",
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              fit: BoxFit.cover,
              // width: 100%,
            ),
            Padding(padding: const EdgeInsets.all(10)),
            Text(
              "You're in! 🥳",
              style: TextStyle(
                color: vanillaBaby,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Just one last thing to set up before your\ncustomers can find you;",
              style: TextStyle(
                color: vanillaBaby,
                fontSize: 16,
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Text(
              "- Add your first product",
              style: TextStyle(
                  color: vanillaBaby,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Text(
              "You can do this now or come back to it\nlater",
              style: TextStyle(
                color: vanillaBaby,
                fontSize: 16,
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Container(
              height: 50,
              child: ElevatedButton(
                style: buttonStyle.copyWith(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(vanillaBaby)),
                onPressed: () async {
                  // Not yet implemented
                },
                child: Text(
                  "Next",
                  style:
                      TextStyle(color: fontType, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Center(
              child: RichText(
                text: TextSpan(
                    text: "Skip for now",
                    style: TextStyle(
                        color: vanillaBaby,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Implement "Skip for now"
                        // Not implemented yet;
                      }),
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
          ],
        ),
      ),
    );
  }
}
