import 'package:flutter/material.dart';
import 'login.dart';
import 'homepage.dart';
import 'adminDashboard.dart';
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
        '/': (context) => const HomePage(),
        '/admin': (context) =>  const AdminPage(),
        '/adminDashboard': (context) => const Admin_Dashboard(),
        // '/third': (context) => const ThirdPageForm(),
        // '/fourth': (context) => const FourthPageForm(),
      },
    );
  }
}


