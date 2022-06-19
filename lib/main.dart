import 'package:flutter/material.dart';
import 'package:med_info/SignInSignUp/hospital_sign_in.dart';
import 'package:med_info/screens/home_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inititlaization = Firebase.initializeApp();
  // const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _inititlaization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              routes: {
                '/login': (BuildContext context) => const HospitalSignIn(),
              },
              title: 'MedInfo',
              theme: ThemeData(primarySwatch: Colors.blue),
              home: HomePage(),
              debugShowCheckedModeBanner: false,
            );
          }
          return CircularProgressIndicator();
        });
  }
}
