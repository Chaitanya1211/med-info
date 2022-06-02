import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceToUser extends StatefulWidget {
  final String id2;
  const ServiceToUser({Key? key, required this.id2}) : super(key: key);

  @override
  State<ServiceToUser> createState() => _ServiceToUserState();
}

// String _image = "";

class _ServiceToUserState extends State<ServiceToUser> {
  late final String service;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = widget.id2;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> services =
        FirebaseFirestore.instance
            .collection('hospitals')
            .doc(service)
            .collection('services')
            .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: services,
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
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Services available"),
              elevation: 20,
            ),
            body: Container(
              color: const Color.fromARGB(255, 142, 233, 145),
              // margin: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 15),
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    // _image = storedocs[i]['docImage'].toString(),
                    // print(storedocs[i]['docImage']),

                    Card(
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
                          ],
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          );
        });
  }
}
