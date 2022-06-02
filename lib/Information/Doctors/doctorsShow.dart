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

// String _image = "";
late var countOfDoc;

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
              title: Text("Doctor Details"),
              elevation: 20,
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/doctor.jpg'),
                      fit: BoxFit.cover)),

              // margin: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 15),
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    // _image = storedocs[i]['docImage'].toString(),
                    // print(storedocs[i]['docImage']),

                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      // color: Color.fromARGB(255, 195, 216, 235),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: double.infinity,
                              child: Image.network(
                                storedocs[i]['docImage'],
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docName'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Registration No",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docRegNo'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Qualification",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docQuali'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Speciality",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docSpec'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Experience",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docExp'])
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
                                              builder: (context) => DoctorEdit(
                                                    id: storedocs[i]['id'],
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 5),
                                        const Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.black),
                                        )
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
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 5),
                                        const Text("Delete",
                                            style:
                                                TextStyle(color: Colors.black))
                                      ],
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                    builder: (context) => const DoctorAdd()));
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
                                const Text("Add Doctor",
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
