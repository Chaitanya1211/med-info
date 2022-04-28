import 'package:flutter/material.dart';
import 'package:med_info/Information/Doctors/doctorsShow.dart';
import 'package:med_info/Information/beds.dart';
import 'package:med_info/Information/services.dart';
import 'package:med_info/screens/Widgets/cards.dart';
import 'package:med_info/screens/Widgets/drawer.dart';

// import '../Information/about_edit.dart';
import '../about/about_show.dart';

class Hospital extends StatefulWidget {
  const Hospital({Key? key}) : super(key: key);

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello')),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Cards(
                Maintitle: "About US",
                Subsubtitle: "Subtitle 1",
                shade: Colors.amber,
                toScreen: DoctorShow(),
              ),
              Cards(
                Maintitle: "Update Beds Availability",
                Subsubtitle: "Subtitle 2",
                shade: Colors.blue,
                toScreen: Beds(),
              ),
              Cards(
                Maintitle: "Update Services",
                Subsubtitle: "Subtitle 3",
                shade: Colors.green,
                toScreen: Services(),
              )
            ],
          )),
        ),
        drawer: HospitalDrawer());
  }
}
