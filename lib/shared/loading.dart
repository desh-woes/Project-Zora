import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_zora/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: thotBlue,
      child: Center(
        child: SpinKitChasingDots(
          color: vanillaBaby,
          size: 50.0,
        ),
      ),
    );
  }
}
