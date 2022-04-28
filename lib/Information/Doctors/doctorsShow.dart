import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_info/Information/Doctors/doctorsAdd.dart';

class DoctorShow extends StatefulWidget {
  const DoctorShow({Key? key}) : super(key: key);

  @override
  State<DoctorShow> createState() => _DoctorShowState();
}

class _DoctorShowState extends State<DoctorShow> {
  CollectionReference doctors = FirebaseFirestore.instance
      .collection('hospitals')
      .doc(FirebaseAuth.instance.currentUser?.uid.toString())
      .collection('doctors');
  Future<void> deleteUser(id) {
    return doctors.doc(id).delete().then((value) {
      Fluttertoast.showToast(
          msg: "Doctor Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Error Occured \n Please try again Later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  final Stream<QuerySnapshot<Map<String, dynamic>>> doctorsStream =
      FirebaseFirestore.instance
          .collection('hospitals')
          .doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection('doctors')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: doctorsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something Went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final List storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
            body: Container(
              margin: EdgeInsetsDirectional.fromSTEB(1, 10, 0, 10),
              child: ListView(
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text("Name : ${storedocs[i]['docName']}"),
                              Text(
                                  "Registration No : ${storedocs[i]['docRegNo']}"),
                              Text(
                                  "Qualification : ${storedocs[i]['docQuali']}"),
                              Text("Speciality : ${storedocs[i]['docSpec']}"),
                              Text("Experience : ${storedocs[i]['docExp']}")
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                deleteUser(storedocs[i]['id']);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 2,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DoctorAdd()));
              },
            ),
          );
        });
    // return Scaffold(
    //   body: Center(
    //     child: ListView(
    //       children: [
    //         Container(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(
    //                 height: 60,
    //                 width: 60,
    //                 color: Colors.amber,
    //               ),
    //               Column(
    //                 children: [
    //                   Text("Name"),
    //                   Text("Registration No"),
    //                   Text("Qualification"),
    //                   Text("Speciality"),
    //                   Text("Experience")
    //                 ],
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     elevation: 2,
    //     child: const Icon(Icons.add),
    //     onPressed: () {
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => const DoctorAdd()));
    //     },
    //   ),
    // );
  }
}
