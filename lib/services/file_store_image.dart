import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class FileStorageService {
  final File image;
  final FirebaseStorage storage = FirebaseStorage.instance;

  FileStorageService({this.image});

  Future<String> uploadPic(BuildContext context, File image) async {
    String fileName = basename(image.path);
    Reference firebaseStorageRef = storage.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl.toString();
  }
}
