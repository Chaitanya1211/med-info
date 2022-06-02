import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:med_info/Information/Beds/bedsAdd.dart';
import 'package:med_info/Information/Beds/bedsEdit.dart';

class Beds extends StatefulWidget {
  const Beds({Key? key}) : super(key: key);

  @override
  State<Beds> createState() => _BedsState();
}

String _image = "";

class _BedsState extends State<Beds> {
  CollectionReference doctors = FirebaseFirestore.instance
      .collection('hospitals')
      .doc(FirebaseAuth.instance.currentUser?.uid.toString())
      .collection('beds');

  Future<void> deleteUser(id) {
    return doctors.doc(id).delete().then((value) {
      Fluttertoast.showToast(
          msg: "Bed Deleted Successfully",
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

  final Stream<QuerySnapshot<Map<String, dynamic>>> bedsStream =
      FirebaseFirestore.instance
          .collection('hospitals')
          .doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection('beds')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: bedsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something Went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Bed Details"),
              elevation: 20,
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bed2.jpg'), fit: BoxFit.cover)),
              // color: Color.fromARGB(255, 142, 233, 145),
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: double.infinity,
                              child: Image.network(
                                storedocs[i]['bedImage'],
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Name",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['bedName'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Bed Type",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['bedType'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Cost",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['bedCost'])
                              ],
                            ),
                            const SizedBox(
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
                                                  new BedsEdit(
                                                    id: storedocs[i]['id'],
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        const Text("Edit",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      deleteUser(storedocs[i]['id']);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "Delete",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
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
            bottomNavigationBar: BottomAppBar(
                elevation: 50.0,
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    // color: Colors.orange,
                    color: Color.fromARGB(255, 160, 182, 201),
                    // borderRadius:
                    //     BorderRadius.vertical(top: Radius.circular(20.0))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Text("Total Doctors : ${storedocs.length}")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BedsAdd()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                const Text("Add Bed",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ))
                    ],
                  ),
                )),
          );
        });
  }
}
