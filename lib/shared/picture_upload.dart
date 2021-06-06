import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  final String imagePath;
  final Function(String) press;

  const ProfilePic({
    Key key,
    @required this.imagePath,
    @required this.press,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File _image;

  Future getImage() async {
    var pickedImage;

    try {
      pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    } catch (e) {
      print(e.code);
    }

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Image setImage() {
    if (_image == null) {
      return Image.network(widget.imagePath);
    }
    return Image.file(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: setImage(),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: SizedBox(
                height: 36,
                width: 36,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white))),
                    padding: MaterialStateProperty.all(EdgeInsets.all(11)),
                  ),
                  child: SvgPicture.asset("images/image_vector.svg"),
                  onPressed: () async {
                    dynamic result;
                    await getImage();
                    // if (_image != null) {
                    //   result = await FileStorageService(image: _image)
                    //       .uploadPic(context, _image);
                    // }
                    if (_image != null) {
                      print(result);
                      widget.press(result);
                    } else {
                      print(result);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
