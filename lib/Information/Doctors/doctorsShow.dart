import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_info/Information/Doctors/doctorsAdd.dart';
import 'package:med_info/Information/Doctors/doctorsEdit.dart';

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
              color: Color.fromARGB(255, 142, 233, 145),
              margin: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 15),
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: double.infinity,
                                color: Colors.amberAccent),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docName'])
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Registration No",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docRegNo'])
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Qualification",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docQuali'])
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Speciality",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docSpec'])
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Experience",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docExp'])
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new DoctorEdit(
                                                    id: storedocs[i]['id'],
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.edit),
                                        Text("Edit")
                                      ],
                                    )),
                                SizedBox(width: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      deleteUser(storedocs[i]['id']);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        Text("Delete")
                                      ],
                                    ))
                              ],
                            )
                          ],
                        ),
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
  }
}
