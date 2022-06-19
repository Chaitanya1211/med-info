import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:med_info/about/about_show.dart';

class AboutUsEdit extends StatefulWidget {
  const AboutUsEdit({Key? key}) : super(key: key);

  @override
  State<AboutUsEdit> createState() => _AboutUsEditState();
}

class _AboutUsEditState extends State<AboutUsEdit> {
  final _formKey = GlobalKey<FormState>();
  late var _lastEdited = "";
  final Stream<QuerySnapshot> about =
      FirebaseFirestore.instance.collection('hospitals').snapshots();

  // TextEditingController _name = TextEditingController();
  TextEditingController _addressStreet = TextEditingController();
  TextEditingController _addressCity = TextEditingController();
  TextEditingController _addressState = TextEditingController();
  TextEditingController _addressPincode = TextEditingController();
  TextEditingController _startTime = TextEditingController();
  TextEditingController _endtime = TextEditingController();
  TextEditingController _established = TextEditingController();
  TextEditingController _phNo = TextEditingController();
  TextEditingController _contactEmail = TextEditingController();
  TextEditingController _url = TextEditingController();

  late String hospImgUrl;

  clearText() {
    _addressState.clear();
    _addressCity.clear();
    _addressStreet.clear();
    _addressPincode.clear();
    _phNo.clear();
    _contactEmail.clear();
    _url.clear();
    _established.clear();
    _established.clear();
    _startTime.clear();
    _endtime.clear();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Personal Information"),
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('hospitals')
                .doc(FirebaseAuth.instance.currentUser?.uid.toString())
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
              // TextEditingController _addressStreet = TextEditingController(
              //     text: (data['addressStreet'] != null)
              //         ? data['addressStreet']
              //         : Text("NULL"));
              // TextEditingController _addressCity = TextEditingController(
              //     text: (data['addressCity'] != null)
              //         ? data['addressCity']
              //         : Text("NULL"));
              // TextEditingController _addressState = TextEditingController(
              //     text: (data['addressState'] != null)
              //         ? data['addressState']
              //         : Text("NULL"));
              // TextEditingController _addressPincode = TextEditingController(
              //     text: (data['addressPincode'] != null)
              //         ? data['addressPincode']
              //         : Text("NULL"));
              // TextEditingController _startTime = TextEditingController(
              //     text: (data['startTime'] != null)
              //         ? data['startTime']
              //         : Text("NULL"));
              // TextEditingController _endtime = TextEditingController(
              //     text: (data['endTime'] != null)
              //         ? data['endTime']
              //         : Text("NULL"));
              // TextEditingController _established = TextEditingController(
              //     text: (data['established'] != null)
              //         ? data['established']
              //         : Text("NULL"));
              // TextEditingController _phNo = TextEditingController(
              //     text: (data['phNo'] != null) ? data['phNo'] : Text("NULL"));
              // TextEditingController _contactEmail = TextEditingController(
              //     text: (data['contactEmail'] != null)
              //         ? data['contactEmail']
              //         : Text("NULL"));
              // TextEditingController _url = TextEditingController(
              //     text: (data['url'] != null) ? data['url'] : Text("NULL"));
              return Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Street Name',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _addressStreet,
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
                            labelText: 'City',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _addressCity,
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
                            labelText: 'State',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _addressState,
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
                            labelText: 'Pincode',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _addressPincode,
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
                            labelText: 'Year of establishment',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _established,
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
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _startTime,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              String formattedTime = pickedTime.format(context);

                              setState(() {
                                _startTime.text =
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
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _endtime,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              String formattedTime = pickedTime.format(context);

                              setState(() {
                                _endtime.text =
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
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _phNo,
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
                            labelText: 'Email',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: const OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _contactEmail,
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
                            labelText: 'Website Link',
                            labelStyle: const TextStyle(fontSize: 20.0),
                            border: const OutlineInputBorder(),
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: _url,
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
                            child: Text("Add Image")),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                hospImgUrl = await uploadFile(_image);
                                var now = new DateTime.now();
                                _lastEdited = DateFormat("yyyy-MM-dd hh:mm:ss")
                                    .format(DateTime.now());
                                CollectionReference hospitals =
                                    FirebaseFirestore.instance
                                        .collection('hospitals');
                                FirebaseAuth auth = FirebaseAuth.instance;
                                String? uid = auth.currentUser?.uid.toString();
                                FirebaseFirestore.instance
                                    .collection('hospitals')
                                    .doc(uid)
                                    .update({
                                  "addressStreet": _addressStreet.text,
                                  "addressCity": _addressCity.text,
                                  "addressState": _addressState.text,
                                  "addressPincode": _addressPincode.text,
                                  "startTime": _startTime.text,
                                  "endTime": _endtime.text,
                                  "phNo": _phNo.text,
                                  "contactEmail": _contactEmail.text,
                                  "url": _url.text,
                                  "established": _established.text,
                                  "lastUpdatedOn": _lastEdited,
                                  "hospImgUrl": hospImgUrl.toString()
                                }).then((value) {
                                  Fluttertoast.showToast(
                                      msg: "Information Updated successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  clearText();
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
                                  clearText();
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
                            },
                            child: const Text("Update")),
                      )
                    ],
                  ),
                ),
              );
            }),
        // body: Form(
        //     key: _formKey,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        //       child: ListView(
        //         children: [
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Street Name',
        //                 labelStyle: TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _addressStreet,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'City',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _addressCity,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'State',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _addressState,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Pincode',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _addressPincode,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Year of establishment',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle: const TextStyle(
        //                     color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _established,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Start time',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _startTime,
        //               onTap: () async {
        //                 TimeOfDay? pickedTime = await showTimePicker(
        //                   initialTime: TimeOfDay.now(),
        //                   context: context,
        //                 );

        //                 if (pickedTime != null) {
        //                   String formattedTime = pickedTime.format(context);

        //                   setState(() {
        //                     _startTime.text =
        //                         formattedTime; //set the value of text field.
        //                   });
        //                 }
        //               },
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'End time',
        //                 labelStyle: TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _endtime,
        //               onTap: () async {
        //                 TimeOfDay? pickedTime = await showTimePicker(
        //                   initialTime: TimeOfDay.now(),
        //                   context: context,
        //                 );

        //                 if (pickedTime != null) {
        //                   String formattedTime = pickedTime.format(context);

        //                   setState(() {
        //                     _endtime.text =
        //                         formattedTime; //set the value of text field.
        //                   });
        //                 }
        //               },
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Phone Number',
        //                 labelStyle: TextStyle(fontSize: 20.0),
        //                 border: OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _phNo,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Email',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: const OutlineInputBorder(),
        //                 errorStyle:
        //                     TextStyle(color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _contactEmail,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             margin: const EdgeInsets.symmetric(vertical: 10.0),
        //             child: TextFormField(
        //               autofocus: false,
        //               decoration: const InputDecoration(
        //                 labelText: 'Website Link',
        //                 labelStyle: const TextStyle(fontSize: 20.0),
        //                 border: const OutlineInputBorder(),
        //                 errorStyle: const TextStyle(
        //                     color: Colors.redAccent, fontSize: 15),
        //               ),
        //               controller: _url,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please Enter Name';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Container(
        //             child: ElevatedButton(
        //                 onPressed: () {
        //                   selectImage();
        //                 },
        //                 child: Text("Add Image")),
        //           ),
        //           Container(
        //             child: ElevatedButton(
        //                 onPressed: () async {
        //                   if (_formKey.currentState!.validate()) {
        //                     hospImgUrl = await uploadFile(_image);
        //                     var now = new DateTime.now();
        //                     _lastEdited = DateFormat("yyyy-MM-dd hh:mm:ss")
        //                         .format(DateTime.now());
        //                     CollectionReference hospitals = FirebaseFirestore
        //                         .instance
        //                         .collection('hospitals');
        //                     FirebaseAuth auth = FirebaseAuth.instance;
        //                     String? uid = auth.currentUser?.uid.toString();
        //                     FirebaseFirestore.instance
        //                         .collection('hospitals')
        //                         .doc(uid)
        //                         .update({
        //                       "addressStreet": _addressStreet.text,
        //                       "addressCity": _addressCity.text,
        //                       "addressState": _addressState.text,
        //                       "addressPincode": _addressPincode.text,
        //                       "startTime": _startTime.text,
        //                       "endTime": _endtime.text,
        //                       "phNo": _phNo.text,
        //                       "contactEmail": _contactEmail.text,
        //                       "url": _url.text,
        //                       "established": _established.text,
        //                       "lastUpdatedOn": _lastEdited,
        //                       "hospImgUrl": hospImgUrl.toString()
        //                     }).then((value) {
        //                       Fluttertoast.showToast(
        //                           msg: "Information Updated successfully",
        //                           toastLength: Toast.LENGTH_SHORT,
        //                           gravity: ToastGravity.BOTTOM,
        //                           timeInSecForIosWeb: 1,
        //                           backgroundColor: Colors.green,
        //                           textColor: Colors.white,
        //                           fontSize: 16.0);

        //                       clearText();
        //                       Navigator.pop(context);
        //                     }).onError((error, stackTrace) {
        //                       Fluttertoast.showToast(
        //                           msg:
        //                               "Information Not Updated \n Try Again Later",
        //                           toastLength: Toast.LENGTH_SHORT,
        //                           gravity: ToastGravity.BOTTOM,
        //                           timeInSecForIosWeb: 1,
        //                           backgroundColor: Colors.red,
        //                           textColor: Colors.white,
        //                           fontSize: 16.0);
        //                       clearText();
        //                     });
        //                   }
        //                 },
        //                 child: const Text("Update")),
        //           )
        //         ],
        //       ),
        //     ))
        // );
        // });
      ),
    );
  }
}
