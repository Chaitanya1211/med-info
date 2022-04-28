import 'package:flutter/material.dart';

class Beds extends StatefulWidget {
  const Beds({Key? key}) : super(key: key);

  @override
  State<Beds> createState() => _BedsState();
}

class _BedsState extends State<Beds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hello Update Bed info")),
    );
  }
}
