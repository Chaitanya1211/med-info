import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'hospital_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _license = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Text("Fill Proper details and get registered"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                    hintText: "Enter Institution Name",
                    prefixIcon: const Icon(Icons.face)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _license,
                decoration: const InputDecoration(
                    hintText: "Enter Institution License",
                    prefixIcon: Icon(Icons.document_scanner)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _email,
                decoration: const InputDecoration(
                    hintText: "Enter ID", prefixIcon: Icon(Icons.email)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _password1,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Enter Password",
                    prefixIcon: const Icon(Icons.password)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _password2,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Re Enter Password",
                    prefixIcon: const Icon(Icons.password)),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email.text, password: _password1.text)
                        .then((value) {
                      print("user registered successfully");
                      Fluttertoast.showToast(
                          msg: "User Registered Successfully !!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      FirebaseFirestore.instance
                          .collection('hospitals')
                          .doc(value.user!.uid)
                          .set({
                        "userName": value.user!.email,
                        "institutename": _name.text,
                        "uid": value.user?.uid,
                        "license": _license.text
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HospitalSignIn()));
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      print("USer not registered");
                      Fluttertoast.showToast(
                          msg: "User Not Registered!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  },
                  child: const Text("Register"))
            ],
          )),
    );
  }
}
