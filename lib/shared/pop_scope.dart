import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/services/authentication_service.dart';
import 'package:provider/provider.dart';

Future<bool> onWillPopDeleteUser(
    BuildContext context, User firebaseUser) async {
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

Future<bool> onWillSignOut(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('You will be logged out if you continue'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut().then((_) {
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
