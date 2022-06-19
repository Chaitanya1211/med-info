import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_info/about/about_show.dart';
import 'package:med_info/SignInSignUp/hospital_sign_in.dart';

class HospitalDrawer extends StatefulWidget {
  const HospitalDrawer({Key? key}) : super(key: key);

  @override
  State<HospitalDrawer> createState() => _HospitalDrawerState();
}

class _HospitalDrawerState extends State<HospitalDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            child: Text('Hello User'),
          ),
          ListTile(
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutShow()));
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HospitalSignIn()),
                  ModalRoute.withName('/login'));
            },
          ),
        ],
      ),
    );
  }
}
