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
                var image = output['image']; // <-- Your value
                return Card(
                  margin: const EdgeInsets.all(60),
                  color: const Color.fromARGB(255, 185, 184, 184),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Institute Name : ${output['institutename']}"),
                        const Text("Address"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Street : ${output['addressStreet']}"),
                        Text("City : ${output['addressCity']}"),
                        Text("State : ${output['addressState']}"),
                        Text("Pincode : ${output['addressPincode']}"),
                        Text(
                            "Year Of establishment : ${output['established']}"),
                        const Text("Working Hours"),
                        Text("From: ${output['startTime']}"),
                        Text("To : ${output['endTime']}"),
                        const Text("Contact Details"),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Phone Number : ${output['phNo']}"),
                        Text("Email : ${output['contactEmail']}"),
                        Text("Website Link : ${output['url']}"),
                        Text("Last Edited on ${output['lastUpdatedOn']}"),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.network(
                            image,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        // ignore: unnecessary_new
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUsEdit()));
            }));
  }
}
