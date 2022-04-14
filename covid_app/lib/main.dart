import 'package:covid_app/adminClinicDashboard.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'homepage.dart';
import 'adminDashboard.dart';
import 'adminHomepage.dart';
// import 'SecondRoutePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Screens',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the homePage widget.
        '/': (context) => const Demo(),
        '/admin': (context) =>  const AdminPage(),
        '/adminDashboard': (context) => const Admin_Dashboard(),
        '/adminClinicDashboard': (context) => const Admin_Clinic_Dashboard(),
        '/adminHomepage': (context) => const AdminHomePage(),
        // '/third': (context) => const ThirdPageForm(),
        // '/fourth': (context) => const FourthPageForm(),
      },
    );
  }
}


