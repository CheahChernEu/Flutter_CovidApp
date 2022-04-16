import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';
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
      clinicID: json['clinic_id'],
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
      Uri.parse('http://192.168.1.104/phpInsertClinic.php'),
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
      .get(Uri.parse('http://192.168.1.104/clinicConvertjson.php'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Clinics.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}



deleteClinic(String clinicID) async {
  final http.Response response = await http.post(
      Uri.parse('http://192.168.1.104/phpDeleteClinic.php'),
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
      Uri.parse('http://192.168.1.104/phpUpdateClinic.php'),
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
              Tab(icon: Icon(Icons.add_box_outlined)),
              Tab(icon: Icon(Icons.view_list_outlined)),
            ],
          ),
          title:  Text(DemoLocalizations.of(context).manageClinics),
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

      body: SingleChildScrollView (
          child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  Text(
                    DemoLocalizations.of(context).addNewClinics,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                        color: Colors.black

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: clinicNameController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).clinicNameHint,
                      labelText: DemoLocalizations.of(context).clinicNameLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).requiredValidation;
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: contactNoController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).contactNoHint,
                      labelText: DemoLocalizations.of(context).contactNoLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).requiredValidation;
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).addressHint,
                      labelText: DemoLocalizations.of(context).addressLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).requiredValidation;
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: vaccineBrandController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).vaccineHint,
                      labelText: DemoLocalizations.of(context).vaccineLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).requiredValidation;
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: latitudeController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).latitudeHint,
                      labelText: DemoLocalizations.of(context).latitudeLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).requiredValidation;
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: longitudeController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).longitudeHint,
                      labelText: DemoLocalizations.of(context).longitudeLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).requiredValidation;
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
          if(clinicNameController.text != '' && contactNoController.text != '' && addressController.text != '' && vaccineBrandController.text != '' && latitudeController.text != '' && longitudeController.text != ''){
            createClinics(clinicNameController.text, contactNoController.text, addressController.text, vaccineBrandController.text, latitudeController.text, longitudeController.text);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(DemoLocalizations.of(context).addedSuccessfully),
                );
              },
            );
          }else{
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(DemoLocalizations.of(context).addFailedButton),
                );
              },
            );
          }
        },
        tooltip: DemoLocalizations.of(context).toolTip,
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
                                  title: Text(DemoLocalizations.of(context).clinicDetails),
                                  content: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(DemoLocalizations.of(context).clinicID + data![index].clinicID),
                                        Text(DemoLocalizations.of(context).clinicName + data![index].clinicName),
                                        Text(DemoLocalizations.of(context).contactNo + data![index].contactNo),
                                        Text(DemoLocalizations.of(context).address + data![index].address),
                                        Text(DemoLocalizations.of(context).vaccineBrand + data![index].vaccineBrand),
                                        Text(DemoLocalizations.of(context).latitude + data![index].latitude),
                                        Text(DemoLocalizations.of(context).longitude + data![index].longitude),
                                      ]
                                  ),
                                  actions: <Widget>[
                                    new ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            final snackBar = SnackBar(
                                              content: Text(DemoLocalizations.of(context).deleteSuccessfullyButton),
                                            );
                                            return AlertDialog(
                                              // Retrieve the text the that user has entered by using the
                                              // TextEditingController.
                                              title: Text(DemoLocalizations.of(context).deleteAlert),
                                              content: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    Text(DemoLocalizations.of(context).clinicID + data![index].clinicID),
                                                    Text(DemoLocalizations.of(context).clinicName + data![index].clinicName),
                                                    Text(DemoLocalizations.of(context).contactNo + data![index].contactNo),
                                                    Text(DemoLocalizations.of(context).address + data![index].address),
                                                    Text(DemoLocalizations.of(context).vaccineBrand + data![index].vaccineBrand),
                                                    Text(DemoLocalizations.of(context).latitude + data![index].latitude),
                                                    Text(DemoLocalizations.of(context).longitude + data![index].longitude),
                                                    new ElevatedButton(
                                                      onPressed: () {
                                                        data?.removeAt(index);
                                                        deleteClinic(item!.getClinicID());
                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                        Navigator.pop(context, DemoLocalizations.of(context).confirmBtn);
                                                        },
                                                      child: Text(DemoLocalizations.of(context).confirmBtn),
                                                    ),

                                                    new ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context, DemoLocalizations.of(context).cancelBtn);
                                                      },
                                                      child: Text(DemoLocalizations.of(context).cancelBtn),
                                                    ),
                                                  ]
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(DemoLocalizations.of(context).deleteBtn),
                                    ),
                                    new ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: UpdatePage(clinicID:item!.getClinicID(), clinicName:item!.clinicName, contactNo:item!.contactNo, address:item!.address, vaccineBrand:item!.vaccineBrand, latitude:item!.latitude, longitude:item!.longitude),
                                            );
                                          },
                                        );
                                        // Navigator.pop(context, 'Update');
                                      },
                                      child: Text(DemoLocalizations.of(context).updateBtn),
                                    ),
                                    new ElevatedButton(
                                      onPressed: () => Navigator.pop(context, DemoLocalizations.of(context).updateBtn),
                                      child: Text(DemoLocalizations.of(context).cancelBtn),
                                    ),
                                  ],
                                ),
                              );
                            },  child: ClinicCard(clinicID:data![index].clinicID, clinicName:data![index].clinicName, contactNo:data![index].contactNo, address:data![index].address, vaccineBrand:data![index].vaccineBrand, latitude:data![index].latitude, longitude:data![index].longitude)),
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

class ClinicCard extends StatelessWidget {
  const ClinicCard({Key? key, required this.clinicID, required this.clinicName, required this.contactNo, required this.address, required this.vaccineBrand, required this.latitude, required this.longitude,}) :
        super(key: key);
  final String clinicID;
  final String clinicName;
  final String contactNo;
  final String address;
  final String vaccineBrand;
  final String latitude;
  final String longitude;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      height: 200,
      width: 350,
      child: Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
                DemoLocalizations.of(context).clinicID + this.clinicID, style: TextStyle(
                fontWeight: FontWeight.bold
            )
            ),
            Text(
                DemoLocalizations.of(context).clinicName + this.clinicName
            ),
            Text(
                DemoLocalizations.of(context).contactNo + this.contactNo
            ),
            Text(
                DemoLocalizations.of(context).address + this.address
            ),
            Text(
                DemoLocalizations.of(context).vaccineBrand + this.vaccineBrand
            ),
            Text(
                DemoLocalizations.of(context).latitude + this.latitude
            ),
            Text(
                DemoLocalizations.of(context).longitude + this.longitude
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
        title: Text(DemoLocalizations.of(context).updateClinicDetails),
      ),
      body: SingleChildScrollView(

          child: new Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(DemoLocalizations.of(context).clinicID + this.clinicID),
                  Text(DemoLocalizations.of(context).clinicName + this.clinicName),
                  Text(DemoLocalizations.of(context).contactNo + this.contactNo),
                  Text(DemoLocalizations.of(context).address + this.address),
                  Text(DemoLocalizations.of(context).vaccineBrand + this.vaccineBrand),
                  Text(DemoLocalizations.of(context).latitude + this.latitude),
                  Text(DemoLocalizations.of(context).longitude + this.longitude),
                ],),),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  Text(
                  DemoLocalizations.of(context).clinicUpdateFormTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                      color: Colors.black
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: clinicNameController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).clinicNameHint,
                    labelText: DemoLocalizations.of(context).clinicNameLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).requiredValidation;
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: contactNoController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).contactNoHint,
                    labelText: DemoLocalizations.of(context).contactNoLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).requiredValidation;
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).addressHint,
                    labelText: DemoLocalizations.of(context).addressLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).requiredValidation;
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: vaccineBrandController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).vaccineHint,
                    labelText: DemoLocalizations.of(context).vaccineLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).requiredValidation;
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: latitudeController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).latitudeHint,
                    labelText: DemoLocalizations.of(context).latitudeLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).requiredValidation;
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: longitudeController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).longitudeHint,
                    labelText: DemoLocalizations.of(context).longitudeLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).requiredValidation;
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
                  if(clinicNameController.text != '' && contactNoController.text != '' && addressController.text != '' && vaccineBrandController.text != '' && latitudeController.text != '' && longitudeController.text != ''){
                    updateClinic(this.clinicID, clinicNameController.text, contactNoController.text, addressController.text, vaccineBrandController.text, latitudeController.text, longitudeController.text );
                    Navigator.pop(context, DemoLocalizations.of(context).cancelBtn);
                  }
                },
                tooltip: DemoLocalizations.of(context).cancelBtn,
              ),
            ],
          )
      ),
    );
  }
}

