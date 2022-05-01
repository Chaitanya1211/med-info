import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Beds extends StatefulWidget {
  const Beds({Key? key}) : super(key: key);

  @override
  State<Beds> createState() => _BedsState();
}

class _BedsState extends State<Beds> {
  late File _image;
  selectImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _image = File(imageFile.path);
      Fluttertoast.showToast(
          msg: "Image selected successfully successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<String> uploadFile(File image) async {
    String downloadURL;
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("post_$postId.jpg");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase() async {
    String url = await uploadFile(
        _image); // this will upload the file and store url in the variable 'url'
    CollectionReference hospitals =
        FirebaseFirestore.instance.collection('hospitals');
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString();
    FirebaseFirestore.instance
        .collection('hospitals')
        .doc(uid)
        .update({"image": url}).then((value) {
      Fluttertoast.showToast(
          msg: "Image Uploaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Image not uploaded \n Try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Container(
          height: 200,
          width: 200,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: FileImage(
          //           _image,
          //         ),
          //         fit: BoxFit.contain)),
          color: Colors.amberAccent,
        ),
        ElevatedButton(
            onPressed: () {
              selectImage();
              // uploadFile(_image);
            },
            child: Text("Add Image")),
        ElevatedButton(
            onPressed: () {
              uploadToFirebase();
            },
            child: Text("Upload image"))
      ])),
    );
  }
}
