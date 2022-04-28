// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../SignInSignUp/hospital_sign_in.dart';

class Cards extends StatelessWidget {
  final Maintitle;
  final Subsubtitle;
  // ignore: prefer_typing_uninitialized_variables
  final shade;
  final toScreen;
  // const Cards({Key? key}) : super(key: key);
  const Cards({this.Maintitle, this.Subsubtitle, this.shade, this.toScreen});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: shade,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(Maintitle),
            SizedBox(height: 4),
            Text(Subsubtitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('EDIT'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => toScreen));
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ]),
        ));
  }
}
