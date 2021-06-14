import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> onWillPop(BuildContext context, User firebaseUser) async {
  return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Your current progress will be lost'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () {
                firebaseUser.delete().then((_) {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName("/authenticationPage"));
                });
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
}
