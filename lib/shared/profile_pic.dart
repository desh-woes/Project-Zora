import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String imagePath;

  const ProfilePic({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 35,
        width: 35,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imagePath),
        ),
      ),
    );
  }
}
