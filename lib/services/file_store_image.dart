import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class FileStorageService {
  final File image;
  final FirebaseStorage storage = FirebaseStorage.instance;

  FileStorageService({this.image});

  Future uploadPic(BuildContext context, File image) async {
    Future<String> url;
    String fileName = basename(image.path);
    Reference firebaseStorageRef = storage.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    uploadTask.then((res) {
      url = res.ref.getDownloadURL();
      print(url);
    });
    return url;
  }
}
