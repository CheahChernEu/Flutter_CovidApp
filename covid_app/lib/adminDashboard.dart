import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'death_cases_series.dart';
import 'death_cases_chart.dart';
import 'new_cases_chart.dart';
import 'new_cases_series.dart';
import 'main.dart';


class Cases {
  final String id;
  final String deathCases;
  final String newCases;
  final String casesDate;


  Cases( { required this.id, required this.deathCases,  required this.newCases, required  this.casesDate});

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
        id: json['case_id'],
        deathCases: json['daily_death_cases'],
        newCases: json['daily_new_cases'],
        casesDate: json['case_date']
    );
  }

  String getId()
  {
    return this.id;
  }
  String getNewCases()
  {
    return this.newCases;
  }

  String getDeathCases()
  {
    return this.deathCases;
  }

  String getCasesDate()
  {
    return this.casesDate;
  }


}

createCases(String deathCases, String newCases, String casesDate) async {


  final response = await http.post(
      Uri.parse('http://192.168.64.2/phpInsert.php'),
      body: {
        'deathCases': deathCases,
        'newCases': newCases,
        'casesDate': casesDate
      }
  );

}

Future <List<Cases>> fetchData() async {
  final response =await http
      .get(Uri.parse('http://192.168.64.2/convertjson.php'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Cases.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}



  deleteCase(String id) async {
    final http.Response response = await http.post(
      Uri.parse('http://192.168.64.2/phpDelete.php'),
      body:{
        'id' : id
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
      throw Exception('Failed to delete daily case.');
    }
  }

updateCase(String id, String newCases, String deathCases, String caseDate) async {
  final http.Response response = await http.post(
      Uri.parse('http://192.168.64.2/phpUpdate.php'),
      body:{
        'id' : id,
        'newCases' : newCases,
        'deathCases' : deathCases,
        'date' : caseDate,
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
    throw Exception('Failed to update daily case.');
  }
}







// Define a custom Form widget.
class Admin_Dashboard extends StatefulWidget {
  const Admin_Dashboard({Key? key}) : super(key: key);

  @override
  AdminDashboard createState() => AdminDashboard();
}

class AdminDashboard extends State<Admin_Dashboard>  {

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  Future<Cases>? _futureEmployee;
  late Future <List<Cases>> futureData;



  final newCasesController = TextEditingController();
  final deathCasesController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newCasesController.dispose();
    deathCasesController.dispose();
    dateController.dispose();
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.add_box_outlined)),
              Tab(icon: Icon(Icons.view_list_outlined)),
              Tab(icon: Icon(Icons.show_chart_outlined)),
              Tab(icon: Icon(Icons.bar_chart_outlined)),
            ],
          ),
          title: Text(DemoLocalizations.of(context).caseBtn),
        ),
        body: TabBarView(
          children: <Widget>[

            AddCases(),
            CasesListing(list: futureData),
            BarChart(list: futureData),
            newCasesBarChart(list: futureData),
          ],
        ),
      ),
    );

  }
}

class AddCases extends StatelessWidget {
   AddCases({Key? key}) : super(key: key);

  final newCasesController = TextEditingController();
  final deathCasesController = TextEditingController();
  final dateController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container (
          child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  Text(DemoLocalizations.of(context).caseFormTitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                      color: Colors.black

                       ),
                  ),
                ),

                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: newCasesController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context).newCaseInputHint,
                    labelText: DemoLocalizations.of(context).newCaseInputLabel,
                  ),
                  validator: (value) {
                    if (value == '') {
                      return DemoLocalizations.of(context).newCaseInputValidation;
                    }
                    return null;
                  },
                ),
              ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: deathCasesController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).deathCaseInputHint,
                      labelText: DemoLocalizations.of(context).deathCaseInputLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).deathCaseInputValidation;
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).caseDateInputHint,
                      labelText: DemoLocalizations.of(context).caseDateInputLabel,
                    ),
                    validator: (value) {
                      if (value == '') {
                        return DemoLocalizations.of(context).caseDateInputValidation;
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
          if(newCasesController.text != '' && deathCasesController.text != '' && dateController.text != ''){
            createCases(newCasesController.text, deathCasesController.text, dateController.text);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(DemoLocalizations.of(context).addSuccessfullyButton),
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
        tooltip: 'Show me the value!',
      ),
    );
  }
}

class CasesListing extends StatelessWidget {
   CasesListing({Key? key, required this.list }) :
        super(key: key);
   Future <List<Cases>> list;


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        height: 110,
        child: Center(
          child: FutureBuilder <List<Cases>>(
            future: list,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Cases>? data = snapshot.data;

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
                              title: Text(DemoLocalizations.of(context).dailyCasesDetails),
                              content: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(DemoLocalizations.of(context).caseID + data![index].id),
                                    Text(DemoLocalizations.of(context).deathCase + data![index].deathCases),
                                    Text(DemoLocalizations.of(context).newCase + data![index].newCases),
                                    Text(DemoLocalizations.of(context).date + data![index].casesDate),



                                 ]
                              ),
                              actions: <Widget>[
                                new ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        final snackBar = SnackBar(
                                        content: Text(DemoLocalizations.of(context).deleteBtn),
                                      );

                                        return AlertDialog(
                                          // Retrieve the text the that user has entered by using the
                                          // TextEditingController.
                                          title: Text(DemoLocalizations.of(context).deleteAlert),
                                          content: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Text(DemoLocalizations.of(context).caseID + data![index].id),
                                                Text(DemoLocalizations.of(context).deathCase + data![index].deathCases),
                                                Text(DemoLocalizations.of(context).newCase + data![index].newCases),
                                                Text(DemoLocalizations.of(context).date + data![index].casesDate),
                                                new ElevatedButton(
                                                onPressed: () {
                                                  data?.removeAt(index);
                                                  deleteCase(item!.getId());
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                  Navigator.pop(context,DemoLocalizations.of(context).confirmBtn);},
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

                                          content: UpdatePage(caseID:item!.getId(), deathCases:item!.deathCases, newCases: item!.newCases,casesDate: item!.casesDate ),
                                        );
                                      },
                                    );

                                    // Navigator.pop(context, 'Update');
                                    },
                                  child: Text(DemoLocalizations.of(context).updateBtn),

                                ),
                                new ElevatedButton(
                                  onPressed: () => Navigator.pop(context, DemoLocalizations.of(context).cancelBtn),
                                  child: Text(DemoLocalizations.of(context).cancelBtn),
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
                                  DemoLocalizations.of(context).caseID + this.caseID, style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                              ),
                             Text(
                                 DemoLocalizations.of(context).deathCase + this.deathCases
                              ),

                           Text(
                               DemoLocalizations.of(context).newCase + this.newCases
                              ),
                            Text(
                                DemoLocalizations.of(context).date + this.casesDate
                              ),
                            ],
                          ),

                    ),
                );
  }
}


class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key, required this.caseID, required this.deathCases, required this.newCases, required this.casesDate}) :
        super(key: key);
  final String caseID;
  final String deathCases;
  final String newCases;
  final String casesDate;

  final newCasesController = TextEditingController();
  final deathCasesController = TextEditingController();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).updateCaseDetails),
      ),
      body: Center(

          child: new Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Card(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(DemoLocalizations.of(context).caseID + this.caseID),
                      Text(DemoLocalizations.of(context).deathCase + this.deathCases),
                      Text(DemoLocalizations.of(context).newCase + this.newCases),
                      Text(DemoLocalizations.of(context).date + this.casesDate)
                    ],),),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child:  Text(
                                DemoLocalizations.of(context).caseUpdateFormTitle,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                                    color: Colors.black

                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child:  TextFormField(
                                controller: newCasesController,
                                decoration: InputDecoration(
                                  hintText: DemoLocalizations.of(context).newCaseInputHint,
                                  labelText: DemoLocalizations.of(context).newCaseInputLabel,
                                ),
                                validator: (value) {
                                  if (value == '') {
                                    return DemoLocalizations.of(context).newCaseInputValidation;
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child:  TextFormField(
                                controller: deathCasesController,
                                decoration: InputDecoration(
                                  hintText: DemoLocalizations.of(context).deathCaseInputHint,
                                  labelText: DemoLocalizations.of(context).deathCaseInputLabel,
                                ),
                                validator: (value) {
                                  if (value == '') {
                                    return DemoLocalizations.of(context).deathCaseInputValidation;
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child:  TextFormField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  hintText: DemoLocalizations.of(context).caseDateInputHint,
                                  labelText: DemoLocalizations.of(context).caseDateInputLabel,
                                ),
                                validator: (value) {
                                  if (value == '') {
                                    return DemoLocalizations.of(context).caseDateInputValidation;
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
                  updateCase(this.caseID, newCasesController.text,deathCasesController.text,dateController.text );
                  Navigator.pop(context, DemoLocalizations.of(context).cancelBtn);
                },
                tooltip: 'Cancel!',
              ),


            ],

          )
      ),
    );
  }
}


class BarChart extends StatelessWidget {
  BarChart({Key? key, required this.list }) :
        super(key: key);
  Future <List<Cases>> list;

  final List<CasesSeries> death_data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 1.5, right: 1.5, top:40.0),
         child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              FutureBuilder <List<Cases>>(
                future: list,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Cases>? data = snapshot.data;
                    for(Cases item in data!){
                      death_data.add(  CasesSeries(
                        day: item!.getCasesDate(),
                        covid_death_cases: int.parse(item!.getDeathCases()),
                          barColor:  (int.parse(item!.getDeathCases())<5000) ?  charts.ColorUtil.fromDartColor(Colors.blue):charts.ColorUtil.fromDartColor(Colors.red),
                      ),);

                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default show a loading spinner.
                  return Text(DemoLocalizations.of(context).deathCasesChartTitle, style: TextStyle(
                      fontWeight: FontWeight.bold));
                },
              ),

             CasesChart(
                data: death_data,
              )
    ],
      ),
    ),);
  }
}

class newCasesBarChart extends StatelessWidget {
  newCasesBarChart({Key? key, required this.list }) :
        super(key: key);
  Future <List<Cases>> list;

  final List<newCasesSeries> new_data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 1.5, right: 1.5, top:40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            FutureBuilder <List<Cases>>(
              future: list,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Cases>? data = snapshot.data;
                  for(Cases item in data!){
                    new_data.add(newCasesSeries(
                      day: item!.getCasesDate(),
                      covid_new_cases: int.parse(item!.getNewCases()),
                      barColor: (int.parse(item!.getNewCases())<10000) ?  charts.ColorUtil.fromDartColor(Colors.purple):charts.ColorUtil.fromDartColor(Colors.red),
                    ),);

                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return Text(DemoLocalizations.of(context).newCasesChartTitle, style: TextStyle(
                    fontWeight: FontWeight.bold));
              },
            ),

            newCasesChart(
              data: new_data,
            )
          ],
        ),
      ),);
  }
}



