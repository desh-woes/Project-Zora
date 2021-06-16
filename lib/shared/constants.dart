import 'package:flutter/material.dart';

const vanillaBaby = Color(0xFFF5F3ED);
const fontType = Color(0xFF2D3748);
const softWork = Color(0xFFFAFAFA);
const thotBlue = Color(0xFF6EBCDD);
const grey = Color(0xFF718096);
const radio = Color(0xFFE2E8F0);

final ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(thotBlue),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )));

final InputDecoration registrationInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: vanillaBaby, width: 1.5),
    ),
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(color: fontType),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ));

final TextStyle detailsStyle = TextStyle(
  color: fontType.withOpacity(0.85),
);

const String defaultUrl =
    "https://firebasestorage.googleapis.com/v0/b/project-zora.appspot.com/o/default_profile_pic.png?alt=media&token=6f5ef5c8-1b93-40f8-b1df-9525baf2385a";
