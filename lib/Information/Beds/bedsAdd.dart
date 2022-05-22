import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class BedsAdd extends StatefulWidget {
  const BedsAdd({Key? key}) : super(key: key);

  @override
  State<BedsAdd> createState() => _BedsAddState();
}

class _BedsAddState extends State<BedsAdd> {
  final _formKey = GlobalKey<FormState>();
  late String bedImg;
  TextEditingController _bedName = TextEditingController();
  TextEditingController _bedCost = TextEditingController();
  TextEditingController _bedType = TextEditingController();
  // TextEditingController _serviceTime = TextEditingController();
  // TextEditingController _serviceInfo = TextEditingController();
  // TextEditingController _servicePrice = TextEditingController();

  late File _image;
  selectImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _image = File(imageFile.path);
      Fluttertoast.showToast(
          msg: "Image selected successfully",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bed Details")),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Bed Name',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _bedName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Bed Type AC/Non AC',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _bedType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Bed Cost',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _bedCost,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        selectImage();
                      },
                      child: const Text("Add Image")),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bedImg = await uploadFile(_image);
                      if (bedImg != null) {
                        CollectionReference hospitals =
                            FirebaseFirestore.instance.collection('hospitals');
                        FirebaseAuth auth = FirebaseAuth.instance;
                        String? uid = auth.currentUser?.uid.toString();
                        FirebaseFirestore.instance
                            .collection('hospitals')
                            .doc(uid)
                            .collection('beds')
                            .doc()
                            .set({
                          "bedName": _bedName.text,
                          "bedType": _bedType.text,
                          "bedCost": _bedCost.text,
                          "bedImage": bedImg.toString()
                        }).then((value) {
                          Fluttertoast.showToast(
                              msg: "Bed Added Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          Navigator.pop(context);
                        }).onError((error, stackTrace) {
                          Fluttertoast.showToast(
                              msg: "Bed Not Added \n Try Again Later",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Fill all the information",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  child: const Text("Add Bed"),
                ))
              ],
            ),
          )),
    );
  }
}
