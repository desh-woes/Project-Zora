import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_zora/services/file_store_image.dart';

class ProfilePicUpload extends StatefulWidget {
  final String imagePath;
  final Function(String) press;

  const ProfilePicUpload({
    Key key,
    @required this.imagePath,
    @required this.press,
  }) : super(key: key);

  @override
  _ProfilePicUploadState createState() => _ProfilePicUploadState();
}

class _ProfilePicUploadState extends State<ProfilePicUpload> {
  File _image;

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 5,
    );
    return compressedFile;
  }

  Future getImage() async {
    var pickedImage;

    try {
      pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    } catch (e) {
      print("Picking Error:" + e.code);
    }

    File newImage;
    if (pickedImage != null) {
      newImage = File(pickedImage.path);
      newImage = await compressFile(newImage);
    }

    setState(() {
      if (pickedImage != null) {
        _image = newImage;
      } else {
        print('No image selected.');
      }
    });
  }

  ImageProvider setImage() {
    if (_image == null) {
      return NetworkImage(widget.imagePath);
    }
    return FileImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE2E8F0),
              backgroundImage: setImage(),
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
                    String result;
                    await getImage();
                    if (_image != null) {
                      print("Image is not null");
                      result = await FileStorageService(image: _image)
                          .uploadPic(context, _image);
                      print(result);
                      widget.press(result);
                    } else {
                      print("Image is Null");
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
