import 'package:flutter/material.dart';
import 'package:med_info/Information/Doctors/doctorsShow.dart';
import 'package:med_info/Information/Services/servicesShow.dart';
import 'package:med_info/Information/Beds/bedsShow.dart';
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
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mainbg.jpg'), fit: BoxFit.cover)),
          // margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Cards(
                Maintitle: "DOCTORS",
                Subsubtitle:
                    "Show the current doctors working with your organization\nAlso showcase their Speciality, Years of Experience and Qualifications.",
                shade: Colors.amber,
                toScreen: DoctorShow(),
                backgrondImg: 'assets/doctor.jpg',
              ),
              Cards(
                Maintitle: "SERVICES",
                Subsubtitle:
                    "Show the current services provided by your organization along with their details such that cost, duration and available time",
                shade: Colors.green,
                toScreen: ServicesShow(),
                backgrondImg: 'assets/services.png',
              ),
              Cards(
                Maintitle: "BEDS",
                Subsubtitle:
                    "Show the current count of beds avaialable in organization along with their cost and type",
                shade: Colors.blue,
                toScreen: Beds(),
                backgrondImg: 'assets/bed2.jpg',
              ),
            ],
          )),
        ),
        drawer: HospitalDrawer());
  }
}
