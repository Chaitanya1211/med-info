import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_info/screens/hospital.dart';
import 'package:med_info/SignInSignUp/signUp.dart';

class HospitalSignIn extends StatefulWidget {
  const HospitalSignIn({Key? key}) : super(key: key);

  @override
  State<HospitalSignIn> createState() => _HospitalSignInState();
}

class _HospitalSignInState extends State<HospitalSignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
                hintText: "Enter User ID", prefixIcon: const Icon(Icons.email)),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Password", prefixIcon: Icon(Icons.password)),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Hospital()));
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _email.text.trim(),
                        password: _password.text.trim())
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Hospital()));
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(
                      msg: "Sign In Failed !!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              child: const Text("Login")),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("New Institution ?? "),
              GestureDetector(
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
              ),
              const Text(" Here")
            ],
          )
        ],
      ),
    ));
  }
}
