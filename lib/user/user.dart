import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_info/user/hospDetailsToUser.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // String _image = '';
  // getImage() {}
  final Stream<QuerySnapshot<Map<String, dynamic>>> hospitalsStream =
      FirebaseFirestore.instance.collection('hospitals').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: hospitalsStream,
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
                title: Text("Welcome User"),
                elevation: 20,
              ),
              body: Container(
                // color: const Color.fromARGB(255, 142, 233, 145),
                color: Color.fromARGB(255, 141, 152, 161),
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    for (var i = 0; i < storedocs.length; i++) ...[
                      // print(storedocs[i]['institutename']);
                      // _image = storedocs[i]['hospImgUrl'],
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: double.infinity,
                                child: Image.network(
                                  storedocs[i]['hospImgUrl'] != null
                                      ? storedocs[i]['hospImgUrl']
                                      : NetworkImage(
                                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
                                          .toString(),
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
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                storedocs[i]['institutename'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(" From "),
                                  Text(storedocs[i]['startTime'] != null
                                      ? storedocs[i]['startTime']
                                      : "NA".toString()),
                                  // Text(" - "),
                                  Text(" To "),
                                  Text(storedocs[i]['endTime'] != null
                                      ? storedocs[i]['endTime']
                                      : "NA".toString())
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Phone Number"),
                              Text(storedocs[i]['phNo'] != null
                                  ? storedocs[i]['phNo']
                                  : "Null".toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HospShow(
                                                    id: storedocs[i]['id'])));
                                      },
                                      child: Text("View More")),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ));
        });
  }
}
