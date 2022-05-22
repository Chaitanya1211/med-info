import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class BedsEdit extends StatefulWidget {
  final String id;
  const BedsEdit({Key? key, required this.id}) : super(key: key);

  @override
  State<BedsEdit> createState() => _BedsEditState();
}

class _BedsEditState extends State<BedsEdit> {
  final _formKey = GlobalKey<FormState>();
  late String bedImage;
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
      appBar: AppBar(title: Text("Update Bed Details")),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('hospitals')
                .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                .collection('beds')
                .doc(widget.id)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Error Occured");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              var data = (snapshot.data!.data() as Map<String, dynamic>);
              // data = ModalRoute.of(context)!.settings.arguments as Map;
              // var name = data['serviceName'];
              TextEditingController _bedName =
                  TextEditingController(text: data['bedName']);
              TextEditingController _bedCost =
                  TextEditingController(text: data['bedCost']);
              TextEditingController _bedType =
                  TextEditingController(text: data['bedType']);
              // TextEditingController _serviceStart =
              //     TextEditingController(text: data['serviceStart']);
              // TextEditingController _serviceTime =
              //     TextEditingController(text: data['serviceTime']);
              // TextEditingController _servicePrice =
              //     TextEditingController(text: data['servicePrice']);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['serviceName'],
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Bed Name',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['docRegNo'],
                        autofocus: false,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Bed Type',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['docQuali'],
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Bed Cost',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
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
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10.0),
                    //   child: TextFormField(
                    //     // initialValue: data['docExp'],
                    //     autofocus: false,
                    //     decoration: InputDecoration(
                    //       labelText: 'Service Duration',
                    //       labelStyle: TextStyle(fontSize: 20.0),
                    //       border: OutlineInputBorder(),
                    //       errorStyle:
                    //           TextStyle(color: Colors.redAccent, fontSize: 15),
                    //     ),
                    //     controller: _serviceTime,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please Enter Name';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10.0),
                    //   child: TextFormField(
                    //     // initialValue: data['docSpec'],
                    //     autofocus: false,
                    //     decoration: InputDecoration(
                    //       labelText: 'Service Cost',
                    //       labelStyle: TextStyle(fontSize: 20.0),
                    //       border: OutlineInputBorder(),
                    //       errorStyle:
                    //           TextStyle(color: Colors.redAccent, fontSize: 15),
                    //     ),
                    //     controller: _servicePrice,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please Enter Name';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10.0),
                    //   child: TextFormField(
                    //     // initialValue: data['docSpec'],
                    //     autofocus: false,
                    //     decoration: InputDecoration(
                    //       labelText: 'Service Description',
                    //       labelStyle: TextStyle(fontSize: 20.0),
                    //       border: OutlineInputBorder(),
                    //       errorStyle:
                    //           TextStyle(color: Colors.redAccent, fontSize: 15),
                    //     ),
                    //     controller: _serviceInfo,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please Enter Name';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   height: MediaQuery.of(context).size.width * 0.5,
                    //   width: double.infinity,
                    //   // color: Colors.amberAccent,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(data['serviceImage']))),
                    // ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          selectImage();
                        },
                        child: Text("Select Image"),
                      ),
                    ),
                    Container(
                        child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bedImage = await uploadFile(_image);
                          if (bedImage != null) {
                            CollectionReference hospitals = FirebaseFirestore
                                .instance
                                .collection('hospitals');
                            FirebaseAuth auth = FirebaseAuth.instance;
                            String? uid = auth.currentUser?.uid.toString();
                            FirebaseFirestore.instance
                                .collection('hospitals')
                                .doc(uid)
                                .collection('beds')
                                .doc(widget.id)
                                .update({
                              "bedName": _bedName.text,
                              "bedCost": _bedCost.text,
                              "bedType": _bedType.text,
                              // "serviceTime": _serviceTime.text,
                              // "servicePrice": _servicePrice.text,
                              "bedImage": bedImage.toString(),
                              // "serviceInfo": _serviceInfo.text
                            }).then((value) {
                              Fluttertoast.showToast(
                                  msg: "Information Updated successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Information Not Updated \n Try Again Later",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Information Not Updated \n Try Again Later",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: const Text("Edit Information"),
                    ))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
