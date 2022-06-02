// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../SignInSignUp/hospital_sign_in.dart';

class Cards extends StatelessWidget {
  final Maintitle;
  final Subsubtitle;
  // ignore: prefer_typing_uninitialized_variables
  final shade;
  final toScreen;
  final backgrondImg;
  // const Cards({Key? key}) : super(key: key);
  const Cards(
      {this.Maintitle,
      this.Subsubtitle,
      this.shade,
      this.toScreen,
      this.backgrondImg});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        color: shade,
        margin: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgrondImg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.55), BlendMode.darken))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(height: 15),
              Text(
                Maintitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 20),
              SizedBox(height: 15),
              Text(
                Subsubtitle,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      'VIEW / EDIT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => toScreen));
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ]),
          ),
        ));
  }
}
