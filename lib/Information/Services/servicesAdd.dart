import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_info/Information/Services/servicesShow.dart';

class ServicesAdd extends StatefulWidget {
  const ServicesAdd({Key? key}) : super(key: key);

  @override
  State<ServicesAdd> createState() => _ServicesAddState();
}

class _ServicesAddState extends State<ServicesAdd> {
  final _formKey = GlobalKey<FormState>();
  late String serviceImg;
  TextEditingController _serviceName = TextEditingController();
  TextEditingController _serviceStart = TextEditingController();
  TextEditingController _serviceEnd = TextEditingController();
  TextEditingController _serviceTime = TextEditingController();
  TextEditingController _serviceInfo = TextEditingController();
  TextEditingController _servicePrice = TextEditingController();

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
      appBar: AppBar(title: const Text("Add Service")),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Service Name',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _serviceName,
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
                      labelText: 'Start time',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _serviceStart,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        String formattedTime = pickedTime.format(context);

                        setState(() {
                          _serviceStart.text =
                              formattedTime; //set the value of text field.
                        });
                      }
                    },
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
                      labelText: 'End time',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _serviceEnd,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        String formattedTime = pickedTime.format(context);

                        setState(() {
                          _serviceEnd.text =
                              formattedTime; //set the value of text field.
                        });
                      }
                    },
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
                      labelText: 'Service Duration',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _serviceTime,
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
                      labelText: 'Service Cost',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _servicePrice,
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
                      labelText: 'Service Description',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _serviceInfo,
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
                      serviceImg = await uploadFile(_image);
                      if (serviceImg != null) {
                        CollectionReference hospitals =
                            FirebaseFirestore.instance.collection('hospitals');
                        FirebaseAuth auth = FirebaseAuth.instance;
                        String? uid = auth.currentUser?.uid.toString();
                        FirebaseFirestore.instance
                            .collection('hospitals')
                            .doc(uid)
                            .collection('services')
                            .doc()
                            .set({
                          "serviceName": _serviceName.text,
                          "serviceStart": _serviceStart.text,
                          "serviceEnd": _serviceEnd.text,
                          "serviceTime": _serviceTime.text,
                          "serviceInfo": _serviceInfo.text,
                          "servicePrice": _servicePrice.text,
                          "serviceImage": serviceImg.toString()
                        }).then((value) {
                          Fluttertoast.showToast(
                              msg: "Service Added Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const ServicesShow()));
                          Navigator.pop(context);
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
                  child: const Text("Add Service"),
                ))
              ],
            ),
          )),
    );
  }
}
