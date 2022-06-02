import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_info/about/about_edit.dart';

class AboutShow extends StatefulWidget {
  const AboutShow({Key? key}) : super(key: key);

  @override
  State<AboutShow> createState() => _AboutShowState();
}

class _AboutShowState extends State<AboutShow> {
  String name = '';
  @override
  // ignore: override_on_non_overriding_member
  final firebaseUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('hospitals')
                .doc(firebaseUser.uid)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');
              if (snapshot.hasData) {
                var output = snapshot.data!.data();
                // ignore: unused_local_variable
                var instituteName = output!['institutename'];
                // var image = output['image']; // <-- Your value
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.amber,
                            height: 300,
                            width: 350,
                            child: (output['hospImgUrl'] != null)
                                ? Image.network(output['hospImgUrl'])
                                : Text("Image not provided"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            // padding: EdgeInsets.all(10),
                            elevation: 10,
                            color: Color.fromARGB(255, 74, 210, 231),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  // padding : const EdgeInsets.all(10),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Institute Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(output['institutename'])
                                  ]),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            color: Colors.blue,
                            child: Column(children: [
                              Text("Institute License Number"),
                              Text(output['license'])
                            ]),
                          ),
                          // (instituteName != null)
                          //     ? Text(
                          //         "Institute Name : ${output['institutename']}")
                          //     : Text("NULL"),
                          // (output['addressStreet'] != null)
                          //     ? Text("Street : ${output['addressStreet']}")
                          //     : Text("NULL"),
                          // (output['addressCity'] != null)
                          //     ? Text("City : ${output['addressCity']}")
                          //     : Text("NULL"),
                          // (output['addressState'] != null)
                          //     ? Text("State : ${output['addressState']}")
                          //     : Text("NULL"),
                          // (output['addressPincode'] != null)
                          //     ? Text(
                          //         "Institute Name : ${output['addressPincode']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text(
                          //         "Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // Container(
                          //   child: Image.network(output['hospImgUrl']),
                          // ),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),
                          // (output['established'] != null)
                          //     ? Text("Institute Name : ${output['established']}")
                          //     : Text("NULL"),

                          // Text("Institute Name : ${output['institutename']}"),
                          // const Text("Address"),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Text("Street : ${output['addressStreet']}"),
                          // Text("City : ${output['addressCity']}"),
                          // Text("State : ${output['addressState']}"),
                          // Text("Pincode : ${output['addressPincode']}"),
                          // Text(
                          //     "Year Of establishment : ${output['established']}"),
                          // const Text("Working Hours"),
                          // Text("From: ${output['startTime']}"),
                          // Text("To : ${output['endTime']}"),
                          // const Text("Contact Details"),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Text("Phone Number : ${output['phNo']}"),
                          // Text("Email : ${output['contactEmail']}"),
                          // Text("Website Link : ${output['url']}"),
                          // Text("Last Edited on ${output['lastUpdatedOn']}"),
                          // Padding(
                          //   padding: EdgeInsets.all(8),
                          //   child: Image.network(
                          //     image,
                          //     loadingBuilder: (BuildContext context, Widget child,
                          //         ImageChunkEvent? loadingProgress) {
                          //       if (loadingProgress == null) return child;
                          //       return Center(
                          //         child: CircularProgressIndicator(
                          //           value: loadingProgress.expectedTotalBytes !=
                          //                   null
                          //               ? loadingProgress.cumulativeBytesLoaded /
                          //                   loadingProgress.expectedTotalBytes!
                          //               : null,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        // ignore: unnecessary_new
        floatingActionButton: new FloatingActionButton.extended(
            elevation: 10,
            // child: const Icon(Icons.edit),
            icon: Icon(Icons.edit),
            label: Text("Edit Information"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUsEdit()));
            }));
  }
}
