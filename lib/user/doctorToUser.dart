import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorToUser extends StatefulWidget {
  final String id2;
  const DoctorToUser({Key? key, required this.id2}) : super(key: key);

  @override
  State<DoctorToUser> createState() => _DoctorToUserState();
}

// String _image = '';

class _DoctorToUserState extends State<DoctorToUser> {
  late final String hosp2;
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hosp2 = widget.id2;
  }

  // @override
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> doctors =
        FirebaseFirestore.instance
            .collection('hospitals')
            .doc(hosp2)
            .collection('doctors')
            .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: doctors,
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
            appBar: AppBar(title: Text("Doctors Available")),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/doctor.jpg'),
                      fit: BoxFit.cover)),

              // color: Color.fromARGB(255, 142, 233, 145),
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //   height: MediaQuery.of(context).size.width * 0.5,
                            //   width: double.infinity,
                            //   // color: Colors.amberAccent,
                            //   decoration: BoxDecoration(
                            //       image: (_image != null)
                            //           ? DecorationImage(
                            //               image: NetworkImage(
                            //               storedocs[i]['docImage'],
                            //             ))
                            //           : const DecorationImage(
                            //               // ignore: unnecessary_const
                            //               image: const NetworkImage(
                            //                   "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"))),
                            // ),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(storedocs[i]['docExp'])
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
