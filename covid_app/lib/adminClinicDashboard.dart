import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Clinics {
  final String clinicID;
  final String clinicName;
  final String contactNo;
  final String address;
  final String vaccineBrand;
  final String latitude;
  final String longitude;

  Clinics( { required this.clinicID, required this.clinicName, required this.contactNo, required this.address, required this.vaccineBrand, required this.latitude, required this.longitude});

  factory Clinics.fromJson(Map<String, dynamic> json) {
    return Clinics(
      clinicID: json['clinic_ID'],
      clinicName: json['clinic_name'],
      contactNo: json['contact_number'],
      address: json['address'],
      vaccineBrand: json['vaccine_brand'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
  String getClinicID() {
    return this.clinicID;
  }

  String getClinicName()
  {
    return this.clinicName;
  }
  String getContactNo()
  {
    return this.contactNo;
  }

  String getAddress()
  {
    return this.address;
  }

  String getVaccineBrand()
  {
    return this.vaccineBrand;
  }

  String getLatitude()
  {
    return this.latitude;
  }

  String getLongitude() {
    return this.longitude;
  }
}

createClinics(String clinicName, String contactNo, String address, String vaccineBrand, String latitude, String longitude) async {


  final response = await http.post(
      Uri.parse('http://192.168.1.6/phpInsert.php'),
      body: {
        'clinicName': clinicName,
        'contactNo': contactNo,
        'address': address,
        'vaccineBrand': vaccineBrand,
        'latitude': latitude,
        'longitude': longitude,
      }
  );

}

Future <List<Clinics>> fetchData() async {
  final response =await http
      .get(Uri.parse('http://192.168.1.6/convertjson.php'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Clinics.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}



deleteClinic(String clinicID) async {
  final http.Response response = await http.post(
      Uri.parse('http://192.168.1.6/phpDelete.php'),
      body:{
        'clinicID' : clinicID
      }
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    print("Returned message: " + response.body.toString());
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete clinic.');
  }
}

updateClinic(String clinicID, String clinicName, String contactNo, String address, String vaccineBrand, String latitude, String longitude) async {
  final http.Response response = await http.post(
      Uri.parse('http://192.168.1.6/phpUpdate.php'),
      body:{
        'clinicID' : clinicID,
        'clinicName' : clinicName,
        'contactNo' : contactNo,
        'address' : address,
        'vaccineBrand' : vaccineBrand,
        'latitude' : latitude,
        'longitude' : longitude,
      }
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    print("Returned message: " + response.body.toString());
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to update clinic.');
  }
}




// Define a custom Form widget.
class Admin_Clinic_Dashboard extends StatefulWidget {
  const Admin_Clinic_Dashboard({Key? key}) : super(key: key);

  @override
  AdminClinicDashboard createState() => AdminClinicDashboard();
}

class AdminClinicDashboard extends State<Admin_Clinic_Dashboard>  {

  // Create a text controller and use it to retrieve the current value
  // of the TextField.


  Future<Clinics>? _futureEmployee;
  late Future <List<Clinics>> futureData;



  final clinicNameController = TextEditingController();
  final contactNoController = TextEditingController();
  final addressController = TextEditingController();
  final vaccineBrandController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    clinicNameController.dispose();
    contactNoController.dispose();
    addressController.dispose();
    vaccineBrandController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }


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
          title: const Text('Manage Clinics'),
        ),
        body: TabBarView(
          children: <Widget>[
            AddClinics(),
            DisplayClinics(list: futureData),
          ],
        ),
      ),
    );

  }
}

class AddClinics extends StatelessWidget {
  AddClinics({Key? key}) : super(key: key);

  final clinicNameController = TextEditingController();
  final contactNoController = TextEditingController();
  final addressController = TextEditingController();
  final vaccineBrandController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container (
          child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  const Text(
                    'Add New Clinics',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                        color: Colors.black

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: clinicNameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Fatimah',
                      labelText: 'Clinic Name',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: contactNoController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 012-3456789',
                      labelText: 'Contact Number',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 48, Jalan Ipoh',
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: vaccineBrandController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Pfizer',
                      labelText: 'Vaccine Brand',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: latitudeController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 3.081213',
                      labelText: 'Latitude',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: longitudeController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 101.5844108',
                      labelText: 'Longitude',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

              ]
          )
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          createClinics(clinicNameController.text, contactNoController.text, addressController.text, vaccineBrandController.text, latitudeController.text, longitudeController.text);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text("Added successfully"),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
      ),
    );
  }
}

class DisplayClinics extends StatelessWidget {
  DisplayClinics({Key? key, required this.list }) :
        super(key: key);
  Future <List<Clinics>> list;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 110,
      child: Center(
        child: FutureBuilder <List<Clinics>>(
          future: list,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Clinics>? data = snapshot.data;

              return
                ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = data?[index];
                      return Center(
                        child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Clinics:'),
                                  content: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text("Clinic Id: " + data![index].clinicID),
                                        Text("Clinic Name: " + data![index].clinicName),
                                        Text("Contact Number: " + data![index].contactNo),
                                        Text("Address: " + data![index].address),
                                        Text("Vaccine Brand: " + data![index].vaccineBrand),
                                        Text("Latitude: " + data![index].latitude),
                                        Text("Longitude: " + data![index].longitude),
                                      ]
                                  ),
                                  actions: <Widget>[
                                    new ElevatedButton(
                                      onPressed: () {
                                        final snackBar = SnackBar(
                                          content: const Text('Delete Successfully!'),
                                        );

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              // Retrieve the text the that user has entered by using the
                                              // TextEditingController.
                                              content: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    new ElevatedButton(
                                                      onPressed: () {
                                                        data?.removeAt(index);
                                                        deleteClinic(item!.getClinicID());
                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                        Navigator.pop(context, 'Confirm');},
                                                      child: const Text('Confirm'),
                                                    ),

                                                    new ElevatedButton(
                                                      onPressed: () {

                                                        Navigator.pop(context, 'Cancel');
                                                      },
                                                      child: const Text('Cancel'),
                                                    ),

                                                  ]
                                              ),
                                            );
                                          },
                                        );


                                        Navigator.pop(context, 'Delete');

                                      },
                                      child: const Text('Delete'),
                                    ),
                                    new ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(

                                              content: UpdatePage(clinicID:item!.getClinicID(), deathCases:item!.deathCases, newCases: item!.newCases,casesDate: item!.casesDate ),
                                            );
                                          },
                                        );

                                        // Navigator.pop(context, 'Update');
                                      },
                                      child: const Text('Update'),

                                    ),
                                    new ElevatedButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                  ],


                                ),



                              );
                            },  child: CaseCard(caseID:data![index].id, deathCases:data![index].deathCases, newCases: data![index].newCases,casesDate: data![index].casesDate )),

                      );
                    }
                );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  const CaseCard({Key? key, required this.caseID, required this.deathCases, required this.newCases, required this.casesDate}) :
        super(key: key);
  final String caseID;
  final String deathCases;
  final String newCases;
  final String casesDate;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      height: 150,
      width: 350,
      child: Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
                "Case ID: " + this.caseID, style: TextStyle(
                fontWeight: FontWeight.bold
            )
            ),
            Text(
                "Daily Death Cases: " + this.deathCases
            ),

            Text(
                "Daily New Cases: " + this.newCases
            ),
            Text(
                "Date: " + this.casesDate
            ),
          ],
        ),

      ),
    );
  }
}


class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key, required this.clinicID, required this.clinicName, required this.contactNo, required this.address, required this.vaccineBrand, required this.latitude, required this.longitude,}) :
        super(key: key);
  final String clinicID;
  final String clinicName;
  final String contactNo;
  final String address;
  final String vaccineBrand;
  final String latitude;
  final String longitude;

  final clinicNameController = TextEditingController();
  final contactNoController = TextEditingController();
  final addressController = TextEditingController();
  final vaccineBrandController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details: '),
      ),
      body: Center(

          child: new Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Case Id: " + this.caseID),
                  Text("Daily Death Cases: " + this.deathCases),
                  Text("Daily New Cases: " + this.newCases),
                  Text("Date: " + this.casesDate)
                ],),),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  const Text(
                  'Daily Cases Update Form: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                      color: Colors.black

                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: newCasesController,
                  decoration: const InputDecoration(
                    hintText: 'Enter daily new cases',
                    labelText: 'Enter Daily New Cases',
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter valid new cases amount';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: deathCasesController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Daily Death Cases',
                    labelText: 'Enter Daily Death Cases',
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter valid death cases amount';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: 'Enter date in 2022-08-08 format',
                    labelText: 'Enter Daily Cases Date',
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter valid date';
                    }
                    return null;
                  },
                ),
              ),

              FloatingActionButton(
                // When the user presses the button, show an alert dialog containing
                // the text that the user has entered into the text field.
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.update),
                onPressed: () {

                  Navigator.pop(context, 'Cancel');
                },
                tooltip: 'Cancel!',
              ),


            ],

          )
      ),
    );
  }
}

