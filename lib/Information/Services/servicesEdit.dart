import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_info/Information/Services/servicesShow.dart';

class ServicesEdit extends StatefulWidget {
  final String id;
  const ServicesEdit({Key? key, required this.id}) : super(key: key);

  @override
  State<ServicesEdit> createState() => _ServicesEditState();
}

class _ServicesEditState extends State<ServicesEdit> {
  final _formKey = GlobalKey<FormState>();
  late String serviceImage;
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
      appBar: AppBar(title: Text("Update Service Details")),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('hospitals')
                .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                .collection('services')
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
              TextEditingController _serviceName =
                  TextEditingController(text: data['serviceName']);
              TextEditingController _serviceInfo =
                  TextEditingController(text: data['serviceInfo']);
              TextEditingController _serviceEnd =
                  TextEditingController(text: data['serviceEnd']);
              TextEditingController _serviceStart =
                  TextEditingController(text: data['serviceStart']);
              TextEditingController _serviceTime =
                  TextEditingController(text: data['serviceTime']);
              TextEditingController _servicePrice =
                  TextEditingController(text: data['servicePrice']);
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
                          labelText: 'Sevice Name',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['docRegNo'],
                        autofocus: false,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Start time',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: _serviceStart,
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
                          labelText: 'End time',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: _serviceEnd,
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
                        // initialValue: data['docExp'],
                        autofocus: false,
                        decoration: InputDecoration(
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['docSpec'],
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Service Cost',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['docSpec'],
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Service Description',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
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
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: double.infinity,
                      // color: Colors.amberAccent,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data['serviceImage']))),
                    ),
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
                          serviceImage = await uploadFile(_image);
                          if (serviceImage != null) {
                            CollectionReference hospitals = FirebaseFirestore
                                .instance
                                .collection('hospitals');
                            FirebaseAuth auth = FirebaseAuth.instance;
                            String? uid = auth.currentUser?.uid.toString();
                            FirebaseFirestore.instance
                                .collection('hospitals')
                                .doc(uid)
                                .collection('doctors')
                                .doc(widget.id)
                                .update({
                              "serviceName": _serviceName.text,
                              "serviceStart": _serviceStart.text,
                              "serviceEnd": _serviceEnd.text,
                              "serviceTime": _serviceTime.text,
                              "servicePrice": _servicePrice.text,
                              "serviceImage": serviceImage.toString(),
                              "serviceInfo": _serviceInfo.text
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
