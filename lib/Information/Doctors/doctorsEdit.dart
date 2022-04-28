import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_info/Information/Doctors/doctorsShow.dart';

class DoctorEdit extends StatefulWidget {
  final String id;
  const DoctorEdit({Key? key, required this.id}) : super(key: key);

  @override
  State<DoctorEdit> createState() => _DoctorEditState();
}

class _DoctorEditState extends State<DoctorEdit> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController _docName = TextEditingController();
  // TextEditingController _docQuali = TextEditingController();
  // TextEditingController _docExp = TextEditingController();
  // TextEditingController _docSpec = TextEditingController();
  // TextEditingController _docRegNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Doctor's Information")),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('hospitals')
                .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                .collection('doctors')
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
              // var name = data['docName'];
              TextEditingController _docName =
                  TextEditingController(text: data['docName']);
              TextEditingController _docQuali =
                  TextEditingController(text: data['docQuali']);
              TextEditingController _docExp =
                  TextEditingController(text: data['docExp']);
              TextEditingController _docSpec =
                  TextEditingController(text: data['docSpec']);
              TextEditingController _docRegNo =
                  TextEditingController(text: data['docRegNo']);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        // initialValue: data['docName'],
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
                        // initialValue: data['docRegNo'],
                        autofocus: false,
                        // ignore: prefer_const_constructors
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
                        // initialValue: data['docQuali'],
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
                        // initialValue: data['docExp'],
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
                        // initialValue: data['docSpec'],
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
                        child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                            "docName": _docName.text,
                            "docQuali": _docQuali.text,
                            "docExp": _docExp.text,
                            "docSpec": _docSpec.text,
                            "docRegNo": _docRegNo.text
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
