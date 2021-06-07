import 'package:flutter/material.dart';

const vanillaBaby = Color(0xFFF5F3ED);
const fontType = Color(0xFF2D3748);
const softWork = Color(0xFFFAFAFA);
const thotBlue = Color(0xFF6EBCDD);
const grey = Color(0xFF718096);

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
