import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math';
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

  double getLatitude()
  {
    return double.parse(this.latitude);
  }

  double getLongitude() {
    return double.parse(this.longitude);
  }
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


class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}


class _MyGoogleMapState extends State<MyGoogleMap> {
  GoogleMapController? mapController; //contrller for Google map
  late Future <List<Clinics>> futureData;
  final Map<String, Marker> _markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
  LatLng startLocation = const LatLng(	3.0747733547685527, 101.74452834886301);
  late LatLng endLocation;
  double distance = 0.0;
  Set<Marker> markers = Set();
  String googleAPiKey = "AIzaSyCw9FAbOyHnq202RNFWEC5dsMTQfa-IHeE";
//markers for google map

  @override

  void initState() {
    //fetch direction polylines from Google API
    futureData = fetchData();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude,endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for(var i = 0; i < polylineCoordinates.length-1; i++){
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i+1].latitude,
          polylineCoordinates[i+1].longitude);
    }


    setState(() {
      distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  Future<void> _onMapCreated(GoogleMapController controller) async {

   final List list = await futureData;

    setState(() {
      _markers.clear();
      for (final clinic in list) {
        final marker = Marker(
          markerId: MarkerId(clinic.getClinicName()),
          position: LatLng(clinic.getLatitude(), clinic.getLongitude()),
          infoWindow: InfoWindow(
            title: clinic.getClinicName(),
            snippet: clinic.getAddress(),
          ),
        );
        _markers[clinic.getClinicName()] = marker;
        markers.add(marker);
      }
    });

  }
   _launchMapsUrl(double lat, double lng) async {
    setState(() {
      endLocation = LatLng(lat, lng);
    });

    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(DemoLocalizations.of(context).vaccinationCentres),
          backgroundColor: Colors.blue[700],
        ),
        body: Column(

            children:[

        Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
              child: Stack ( children: [
                GoogleMap(      onMapCreated: _onMapCreated,
                  //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 15.0, //initial zoom level
                  ),
                  // _markers.values.toSet()
                  markers:  markers, //markers to show on map
                  polylines: Set<Polyline>.of(polylines.values), //polylines
                  mapType: MapType.normal, //map type

                ),

                Positioned(
                    top: 200,
                    left: 45,
                    child: Container(
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(3),
                              child: Text(DemoLocalizations.of(context).totalDistance + distance.toStringAsFixed(2) + DemoLocalizations.of(context).km,
                                  style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold))
                          ),
                        )
                    )
                )
              ],
        ),),
              SizedBox(
                height: 10.0,
              ),
              Flexible(
               child: FutureBuilder <List<Clinics>>(
                 future: futureData,
                 builder: (context, snapshot) {
                   if (snapshot.hasData) {
                     List<Clinics>? data = snapshot.data;
                       return SingleChildScrollView(
                         physics: ScrollPhysics(),
                         child: ListView.builder(
                             physics: const NeverScrollableScrollPhysics(),
                             shrinkWrap: true,

                           itemCount: data?.length,
                           itemBuilder: (BuildContext context, int index) {




                             for (int pointer = 0; pointer < data!.length-1; pointer++){
                               var item1 = data[pointer];
                               var item2 = data[pointer+1];
                               double ele1 =  calculateDistance(startLocation.latitude, startLocation.longitude, item1!.getLatitude(), item1!.getLongitude());
                               double ele2 = calculateDistance(startLocation.latitude, startLocation.longitude, item2!.getLatitude(), item2!.getLongitude());
                               if(ele1 > ele2){
                                 var temp = data[pointer];
                                 data[pointer] = data[pointer+1];
                                 data[pointer+1] = temp;
                                 pointer = -1;
                               }
                               data.add(data[pointer]);
                             }
                             final item = data?[index];


                             return Center(
                               child: Card(
                                 child: ListTile(
                                   title: Text(data![index].clinicName),
                                   subtitle: Column(
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     children: <Widget>[
                                       SizedBox(
                                         height: 3.0,
                                       ),
                                       Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           crossAxisAlignment: CrossAxisAlignment.stretch,

                                           children: <Widget> [
                                         Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                           child:  Text(DemoLocalizations.of(context).availableVaccine + item!.getVaccineBrand())
                                           ),
                                             Padding(
                                                 padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                                 child:  Text(DemoLocalizations.of(context).address  + item!.getAddress())
                                             ),

                                         Padding(
                                             padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                             child:  Text(DemoLocalizations.of(context).hotline  + item!.getContactNo())
                                         ),
                                             Padding(

                                                 padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                                 child:  Text(DemoLocalizations.of(context).distance +  calculateDistance(startLocation.latitude, startLocation.longitude, item!.getLatitude(), item!.getLongitude()).toStringAsFixed(2).toString() +  DemoLocalizations.of(context).km)
                                             ),


                                       ]),
                                       SizedBox(
                                         height: 5.0,
                                       ),
                                     ],
                                   ),
                                   trailing: IconButton(
                                     icon: Icon(Icons.directions),
                                     color:
                                     Theme.of(context).primaryColor,
                                     onPressed: () {

                                      _launchMapsUrl(item!.getLatitude(), item!.getLongitude());

                                     },

                                   ),
                                 ),
                               ),

                             );
                           }
                       ),);
                   } else if (snapshot.hasError) {
                     return Text("${snapshot.error}");
                   }
                   // By default show a loading spinner.
                   return const CircularProgressIndicator();
                 },
               ),
              ),
            ]
        )
      );
  }
}



