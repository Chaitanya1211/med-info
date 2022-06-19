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
  String _image = '';
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
      // padding: EdgeInsets.all(20),
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
          return Scaffold(
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${data['institutename']}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: double.infinity,
                      child: Image.network(
                        data['hospImgUrl'] != null
                            ? data['hospImgUrl']
                            : NetworkImage(
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
                                .toString(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "${data['addressStreet'] != null ? data['addressStreet'] : Text("NA")}, ${data['addressCity'] != null ? data['addressCity'] : Text("NA")}, ${data['addressState'] != null ? data['addressState'] : Text("NA")}, ${data['addressPincode'] != null ? data['addressPincode'] : Text("NA")}")
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          "Contact Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Phone Number : ${data['phNo'] != null ? data['phNo'] : Text("Not Updated")}"),
                        Text(
                            "Email : ${data['contactEmail'] != null ? data['contactEmail'] : Text("Not Updated")}"),
                        Text(
                            "Website : ${data['url'] != null ? data['url'] : Text("Not Updated")}")
                      ]),
                    ),
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
