import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_info/Information/Doctors/doctorsShow.dart';
import 'package:image_picker/image_picker.dart';

class DoctorAdd extends StatefulWidget {
  const DoctorAdd({Key? key}) : super(key: key);

  @override
  State<DoctorAdd> createState() => _DoctorAddState();
}

class _DoctorAddState extends State<DoctorAdd> {
  final _formKey = GlobalKey<FormState>();
  late String profileUrl;
  TextEditingController _docName = TextEditingController();
  TextEditingController _docQuali = TextEditingController();
  TextEditingController _docExp = TextEditingController();
  TextEditingController _docSpec = TextEditingController();
  TextEditingController _docRegNo = TextEditingController();

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
      appBar: AppBar(title: Text("Add Doctors")),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Doctor Name',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _docName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Doctor Registration Number',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _docRegNo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Doctor Qualification',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _docQuali,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Doctor Experience',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _docExp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Doctor Specility',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _docSpec,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              selectImage();
                            },
                            child: Text("Select Image")),
                      ],
                    )
                  ]),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      profileUrl = await uploadFile(_image);
                      if (profileUrl != null) {
                        CollectionReference hospitals =
                            FirebaseFirestore.instance.collection('hospitals');
                        FirebaseAuth auth = FirebaseAuth.instance;
                        String? uid = auth.currentUser?.uid.toString();
                        FirebaseFirestore.instance
                            .collection('hospitals')
                            .doc(uid)
                            .collection('doctors')
                            .doc()
                            .set({
                          "docName": _docName.text,
                          "docQuali": _docQuali.text,
                          "docExp": _docExp.text,
                          "docSpec": _docSpec.text,
                          "docRegNo": _docRegNo.text,
                          "docImage": profileUrl.toString()
                        }).then((value) {
                          Fluttertoast.showToast(
                              msg: "Information Updated successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DoctorShow()));
                        }).onError((error, stackTrace) {
                          Fluttertoast.showToast(
                              msg: "Information Not Updated \n Try Again Later",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Information Not Updated \n Try Again Later",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  child: const Text("Add Doctor"),
                ))
              ],
            ),
          )),
    );
  }
}
