import 'package:flutter/material.dart';
import 'package:med_info/Information/Services/servicesAdd.dart';

class ServicesShow extends StatefulWidget {
  const ServicesShow({Key? key}) : super(key: key);

  @override
  State<ServicesShow> createState() => _ServicesShowState();
}

class _ServicesShowState extends State<ServicesShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 5,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ServicesAdd()));
          }),
    );
  }
}
