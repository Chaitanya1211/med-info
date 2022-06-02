import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:med_info/user/bedsToUser.dart';
import 'package:med_info/user/doctorToUser.dart';
import 'package:med_info/user/serviceToUser.dart';

class HospShow extends StatefulWidget {
  final String id;
  const HospShow({Key? key, required this.id}) : super(key: key);

  @override
  State<HospShow> createState() => _HospShowState();
}

class _HospShowState extends State<HospShow> {
  late final String hosp;
  @override
  void initState() {
    // TODO: implement initState
    hosp = widget.id;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future:
            FirebaseFirestore.instance.collection('hospitals').doc(hosp).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error Occured");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var data = (snapshot.data!.data() as Map<String, dynamic>);
          return Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Name of hospital : ${data['institutename']}"),
                    // Text("Name of hospital : ${data['institutename']}"),
                    // Text("Name of hospital : ${data['institutename']}"),
                    // Text("Name of hospital $data['url']"),
                    // Text("Name of hospital $data['startTime']"),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorToUser(id2: hosp)));
                        },
                        child: Text("View Doctors Available")),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BedsToUser(id2: hosp)));
                        },
                        child: Text("View Beds Available")),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceToUser(id2: hosp)));
                        },
                        child: Text("View Services Available"))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
