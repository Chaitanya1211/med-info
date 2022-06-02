import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BedsToUser extends StatefulWidget {
  final String id2;
  const BedsToUser({Key? key, required this.id2}) : super(key: key);

  @override
  State<BedsToUser> createState() => _BedsToUserState();
}

class _BedsToUserState extends State<BedsToUser> {
  late final String bed;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bed = widget.id2;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> beds = FirebaseFirestore
        .instance
        .collection('hospitals')
        .doc(bed)
        .collection('beds')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: beds,
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
                                  "Type",
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
                                  "Price",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['bedCost'])
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
