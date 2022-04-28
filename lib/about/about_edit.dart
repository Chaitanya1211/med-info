import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Personal Information"),
        ),
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
                        labelText: 'Street Name',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'State',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Pincode',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Year of establishment',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Start time',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'End time',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Website Link',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
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
                          if (_formKey.currentState!.validate()) {
                            var now = new DateTime.now();
                            _lastEdited = DateFormat("yyyy-MM-dd hh:mm:ss")
                                .format(DateTime.now());
                            CollectionReference hospitals = FirebaseFirestore
                                .instance
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
                              "lastUpdatedOn": _lastEdited
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AboutShow()));
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
                          }
                        },
                        child: const Text("Update")),
                  )
                ],
              ),
            )));
    // });
  }
}
