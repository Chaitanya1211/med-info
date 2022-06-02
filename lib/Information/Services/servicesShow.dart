import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_info/Information/Services/servicesAdd.dart';
import 'package:med_info/Information/Services/servicesEdit.dart';

class ServicesShow extends StatefulWidget {
  const ServicesShow({Key? key}) : super(key: key);

  @override
  State<ServicesShow> createState() => _ServicesShowState();
}

class _ServicesShowState extends State<ServicesShow> {
  String _image = "";
  CollectionReference doctors = FirebaseFirestore.instance
      .collection('hospitals')
      .doc(FirebaseAuth.instance.currentUser?.uid.toString())
      .collection('services');
  Future<void> deleteService(id) {
    return doctors.doc(id).delete().then((value) {
      Fluttertoast.showToast(
          msg: "Service Removed Successfully",
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

  final Stream<QuerySnapshot<Map<String, dynamic>>> servicesStream =
      FirebaseFirestore.instance
          .collection('hospitals')
          .doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection('services')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: servicesStream,
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
              title: Text("Services available"),
              elevation: 20,
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/services.png'),
                      fit: BoxFit.cover)),
              // color: const Color.fromARGB(255, 142, 233, 145),
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
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: double.infinity,
                              child: Image.network(
                                storedocs[i]['serviceImage'],
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
                                Text(storedocs[i]['serviceName'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Information",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['serviceInfo'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Price",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['servicePrice'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Start Time",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['serviceStart'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "End Time",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['serviceEnd'])
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Duration",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['serviceTime'])
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
                                                  new ServicesEdit(
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
                                      deleteService(storedocs[i]['id']);
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
                          child: Text("Total Services : ${storedocs.length}")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ServicesAdd()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                const Text("Add new Service",
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
