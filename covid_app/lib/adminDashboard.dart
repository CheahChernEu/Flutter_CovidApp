import 'package:flutter/material.dart';



class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add_location)),

                Tab(icon: Icon(Icons.add_chart_outlined)),
              ],
            ),
            title: const Text('Admin Dashboard'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.add_location_outlined),

              Icon(Icons.add_chart_sharp),
            ],
          ),
        ),
      );

  }
}