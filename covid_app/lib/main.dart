import 'package:covid_app/adminClinicDashboard.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'homepage.dart';
import 'adminDashboard.dart';
import 'adminHomepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'GoogleMap.dart';

void main() {
  runApp(const MyApp());
}

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of (context, DemoLocalizations);
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Covid_App Homepage',
      'message': 'Stay Healthy! Prevent Covid-19!',
      'adminBtn': 'Admin',
      'clientBtn': 'Client',
      'loginTitle': 'Welcome to Covid_App',
      'loginMessage': 'We Provide The Best Covid-19 Services \nStay Happy Always',
      'loginHeading': 'Login to Covid_App',
      'loginEmail': 'Enter your email',
      'loginPw': 'Enter your password',
      'emailValidation': 'Please enter valid email address',
      'pwValidation': 'Please enter valid password',
      'loginText': 'Login',
      'successfulLoginAlert': 'Successful Login!',
      'failedLoginAlert': 'Login Failed -- Please Try Again!',
      'adminHomepageTitle': 'Admin Homepage',
      'caseBtn': 'Daily Cases Management',
      'clinicBtn': 'Clinics Management',
      'caseFormTitle': 'Daily Cases Submission Form',
      'newCaseInputLabel': 'Enter Daily New Cases',
      'newCaseInputHint': 'e.g. 10000',
      'newCaseInputValidation': 'Please enter valid new cases amount',
      'deathCaseInputLabel': 'Enter Daily Death Cases',
      'deathCaseInputHint': 'e.g. 100',
      'deathCaseInputValidation': 'Please enter valid death cases amount',
      'caseDateInputLabel': 'Enter Daily Cases Date',
      'caseDateInputHint': 'e.g. 2022-08-12',
      'caseDateInputValidation': 'Please enter valid date',
      'addSuccessfullyButton': 'Added Successfully!',
      'addFailedButton': 'Added Failed!',
      'caseID': 'Case ID: ',
      'deathCase': 'Daily Death Case: ',
      'newCase': 'Daily New Case: ',
      'date': 'Date: ',
      'dailyCasesDetails' : 'Daily Cases Details: ',
      'deleteSuccessfullyButton': 'Delete Successfully!',
      'deleteAlert': 'Delete Alert???',
      'deleteBtn' : 'Delete',
      'confirmBtn': 'Confirm',
      'cancelBtn': 'Cancel',
      'updateBtn': 'Update',
      'updateCaseDetails': 'Update Case Details: ',
      'caseUpdateFormTitle': 'Daily Cases Update Form',
      'deathCasesChartTitle': 'Covid-19 Death Cases Chart:',
      'newCasesChartTitle': 'Covid-19 New Cases Chart:',
      'deathCasesChartHeading': 'Covid-19 Death Cases by Date',
      'newCasesChartHeading': 'Covid-19 New Cases by Date',
      'vaccinationCentres': 'Covid_19 Vaccination Centres',
      'totalDistance':'Total Distance: ',
      'km':' KM',
      'availableVaccine': 'Vaccine Available: ',
      'address':'Address: ',
      'hotline':'Hotline: ',
      'distance':'Distance: ',
      'startingPoint':'Starting Point',
      'startMarker':'Start Marker',
      'destinationPoint':'Destination Point',
      'destinationMarker': 'Destination Marker',
      'toolTip':'Show me the value!',
      'addedSuccessfully':'Added successfully',
      'longitudeLabel':'Longitude',
      'longitudeHint':'e.g. 101.5844108',
      'latitudeLabel':'Latitude',
      'latitudeHint':'e.g. 3.081213',
      'vaccineLabel':'Vaccine Brand',
      'vaccineHint':'e.g. Pfizer',
      'addressLabel':'Address',
      'addressHint':'e.g. 48, Jalan Ipoh',
      'contactNoLabel':'Contact Number',
      'contactNoHint':'e.g. 012-3456789',
      'manageClinics':'Manage Clinics',
      'addNewClinics':'Add New Clinics',
      'clinicNameHint':'e.g. Fatimah',
      'clinicNameLabel':'Clinic Name',
      'requiredValidation':'The field is required',
      'clinicID': 'Clinic ID: ',
      'clinicName': 'Clinic Name: ',
      'contactNo': 'Contact Number: ',
      'vaccineBrand': 'Vaccine Brand: ',
      'latitude': 'Latitude: ' ,
      'longitude': 'Longitude: ',
      'clinicDetails' : 'Clinic Details: ',
      'updateClinicDetails': 'Update Clinic Details: ',
      'clinicUpdateFormTitle': 'Clinic Update Form',

    },
    'ms': {
      'title': 'Laman Utama Covid_App',
      'message': 'Kekal Sihat! Mencegah Covid-19!',
      'adminBtn': 'Admin',
      'clientBtn': 'Pelanggan',
      'loginTitle': 'Selamat Datang ke Covid_App',
      'loginMessage': 'Kami Menyediakan Perkhidmatan Covid-19 Terbaik \nKekal Gembira Sentiasa',
      'loginHeading': 'Log Masuk ke Covid_App',
      'loginEmail': 'Masukkan emel anda',
      'loginPw': 'Masukkan kata laluan anda',
      'emailValidation': 'Sila masukkan emel yang sah',
      'pwValidation': 'Sila masukkan kata laluan yang sah',
      'loginText': 'Log Masuk',
      'successfulLoginAlert': 'Log Masuk Berjaya!',
      'failedLoginAlert': 'Log Masuk Gagal -- Sila Cuba Lagi!',
      'adminHomepageTitle': 'Laman Utama Admin',
      'caseBtn': 'Pengurusan Kes Harian',
      'clinicBtn': 'Pengurusan Klinik',
      'caseFormTitle': 'Borang Penyerahan Kes Harian',
      'newCaseInputLabel': 'Masukkan Kes Baharu Harian',
      'newCaseInputHint': 'cth. 10000',
      'newCaseInputValidation': 'Sila masukkan kes baharu harian yang sah',
      'deathCaseInputLabel': 'Masukkan Kes Kematian Harian',
      'deathCaseInputHint': 'cth. 100',
      'deathCaseInputValidation': 'Sila masukkan kes kematian harian yang sah',
      'caseDateInputLabel': 'Masukkan Tarikh Kes Harian',
      'caseDateInputHint': 'cth. 2022-08-12',
      'caseDateInputValidation': 'Sila masukkan tarikh yang sah',
      'addSuccessfullyButton': 'Berjaya Ditambahkan!',
      'addFailedButton': 'Gagal Ditambahkan!',
      'caseID': 'Kes ID: ',
      'deathCase': 'Kes Kematian Harian: ',
      'newCase': 'Kes Baharu Harian: ',
      'date': 'Tarikh: ',
      'dailyCasesDetails' : 'Butiran Kes Harian : ',
      'deleteSuccessfullyButton': 'Berjaya Dipadamkan!',
      'deleteAlert': 'Amaran Pemadaman???',
      'deleteBtn' : 'Memadamkan',
      'confirmBtn': 'Mengesahkan',
      'cancelBtn': 'Membatalkan',
      'updateBtn': 'Kemas Kini',
      'updateCaseDetails': 'Kemas Kini Butiran Kes: ',
      'caseUpdateFormTitle': 'Borang Kemas Kini Kes Harian',
      'deathCasesChartTitle': 'Carta Kes Kematian Covid-19:',
      'newCasesChartTitle': 'Carta Kes Baharu Covid-19:',
      'deathCasesChartHeading': 'Kes Kematian Covid-19 mengikut Tarikh',
      'newCasesChartHeading': 'Kes Baharu Covid-19 mengikut Tarikh',
      'vaccinationCentres' : 'Pusat Vaksinasi Covid-19',
      'totalDistance':'Jumlah Jarak: ',
      'km': ' KM',
      'availableVaccine': 'Vaksin yang Tersedia: ',
      'address':'Alamat: ',
      'hotline':'Talian Hotline: ',
      'distance':'Jarak: ',
      'startingPoint':'Titik Permulaan',
      'startMarker':'Penanda Mula',
      'destinationPoint':'Titik Destinasi',
      'destinationMarker': 'Penanda Destinasi',
      'toolTip':'Tunjukkan saya nilainya!',
      'addedSuccessfully':'Berjaya ditambahkan',
      'longitudeLabel':'Longitud',
      'longitudeHint':'cth. 101.5844108',
      'latitudeLabel':'Latitud',
      'latitudeHint':'cth. 3.081213',
      'vaccineLabel':'Jenama Vaksin',
      'vaccineHint':'cth. Pfizer',
      'addressLabel':'Alamat',
      'addressHint':'cth. 48, Jalan Ipoh',
      'contactNoLabel':'Nombor telefon',
      'contactNoHint':'cth. 012-3456789',
      'manageClinics':'Pengurusan Klinik',
      'addNewClinics':'Tambah Klinik Baru',
      'clinicNameHint':'cth. Fatimah',
      'clinicNameLabel':'Nama Klinik',
      'requiredValidation':'Medan diperlukan',
      'clinicID': 'Klinik ID: ',
      'clinicName': 'Nama Klinik: ',
      'contactNo': 'Nombor telefon: ',
      'vaccineBrand': 'Jenama Vaksin: ',
      'latitude': 'Latitud: ' ,
      'longitude': 'Longitud: ',
      'clinicDetails' : 'Butiran Klinik: ',
      'updateClinicDetails': 'Kemas Kini Butiran Klinik: ',
      'clinicUpdateFormTitle': 'Borang Kemas Kini Klinik',

  },
    'zh': {
      'title': 'Covid_App ??????',
      'message': '?????????????????????????????????',
      'adminBtn': '?????????',
      'clientBtn': '??????',
      'loginTitle': '???????????? Covid_App',
      'loginMessage': '????????????????????? Covid-19 ??????\n????????????',
      'loginHeading': '?????? Covid_App',
      'loginEmail': '????????????????????????',
      'loginPw': '??????????????????',
      'emailValidation': '??????????????????????????????',
      'pwValidation': '????????????????????????',
      'loginText': '??????',
      'successfulLoginAlert': '???????????????',
      'failedLoginAlert': '???????????? -- ????????????',
      'adminHomepageTitle': '???????????????',
      'caseBtn': '??????????????????',
      'clinicBtn': '????????????',
      'caseFormTitle': '?????????????????????',
      'newCaseInputLabel': '????????????????????????',
      'newCaseInputHint': '?????? 10000',
      'newCaseInputValidation': '????????????????????????????????????',
      'deathCaseInputLabel': '????????????????????????',
      'deathCaseInputHint': '?????? 100',
      'deathCaseInputValidation': '????????????????????????????????????',
      'caseDateInputLabel': '????????????????????????',
      'caseDateInputHint': '?????? 2022-08-12',
      'caseDateInputValidation': '????????????????????????',
      'addSuccessfullyButton': '???????????????',
      'addFailedButton': '???????????????',
      'caseID': '?????? ID: ',
      'deathCase': '??????????????????: ',
      'newCase': '??????????????????: ',
      'date': '??????: ',
      'dailyCasesDetails' : '?????????????????? : ',
      'deleteSuccessfullyButton': '???????????????',
      'deleteAlert': '???????????????',
      'deleteBtn' : '??????',
      'confirmBtn': '??????',
      'cancelBtn': '??????',
      'updateBtn': '??????',
      'updateCaseDetails': '??????????????????: ',
      'caseUpdateFormTitle': '?????????????????????',
      'deathCasesChartTitle': '??????????????????????????????:',
      'newCasesChartTitle': '??????????????????????????????:',
      'deathCasesChartHeading': '??????????????????????????????????????????',
      'newCasesChartHeading': '??????????????????????????????????????????',
      'vaccinationCentres': 'Covid-19 ??????????????????',
      'totalDistance':'?????????: ',
      'km':" ??????",
      'availableVaccine': "????????????: ",
      'address':"??????: ",
      'hotline':'??????: ',
      'distance':'??????: ',
      'startingPoint':'??????',
      'startMarker':'????????????',
      'destinationPoint':'????????????',
      'destinationMarker': '???????????????',
      'toolTip':'??????????????????',
      'addedSuccessfully':'????????????',
      'longitudeLabel':'??????',
      'longitudeHint':'?????? 101.5844108',
      'latitudeLabel':'??????',
      'latitudeHint':'?????? 3.081213',
      'vaccineLabel':'????????????',
      'vaccineHint':'?????? ??????',
      'addressLabel':'??????',
      'addressHint':'?????? 48, ?????????',
      'contactNoLabel':'????????????',
      'contactNoHint':'?????? 012-3456789',
      'manageClinics':'????????????',
      'addNewClinics':'???????????????',
      'clinicNameHint':'?????? ?????????',
      'clinicNameLabel':'????????????',
      'requiredValidation':'?????????????????????',
      'clinicID': '?????? ID: ',
      'clinicName': '????????????: ',
      'contactNo': '????????????: ',
      'vaccineBrand': '????????????: ',
      'latitude': '??????: ' ,
      'longitude': '??????: ',
      'clinicDetails': '????????????: ',
      'updateClinicDetails': '??????????????????: ',
      'clinicUpdateFormTitle': '???????????????',
    },
  };

  static List<String> languages ()=> _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get message {
    return _localizedValues[locale.languageCode]!['message']!;
  }

  String get adminBtn {
    return _localizedValues[locale.languageCode]!['adminBtn']!;
  }

  String get clientBtn {
    return _localizedValues[locale.languageCode]!['clientBtn']!;
  }

  String get loginTitle {
    return _localizedValues[locale.languageCode]!['loginTitle']!;
  }

  String get loginMessage {
    return _localizedValues[locale.languageCode]!['loginMessage']!;
  }

  String get loginHeading {
    return _localizedValues[locale.languageCode]!['loginHeading']!;
  }

  String get loginEmail {
    return _localizedValues[locale.languageCode]!['loginEmail']!;
  }

  String get loginPw {
    return _localizedValues[locale.languageCode]!['loginPw']!;
  }

  String get emailValidation {
    return _localizedValues[locale.languageCode]!['emailValidation']!;
  }

  String get pwValidation {
    return _localizedValues[locale.languageCode]!['pwValidation']!;
  }

  String get loginText {
    return _localizedValues[locale.languageCode]!['loginText']!;
  }

  String get successfulLoginAlert {
    return _localizedValues[locale.languageCode]!['successfulLoginAlert']!;
  }

  String get failedLoginAlert {
    return _localizedValues[locale.languageCode]!['failedLoginAlert']!;
  }

  String get adminHomepageTitle {
    return _localizedValues[locale.languageCode]!['adminHomepageTitle']!;
  }

  String get caseBtn {
    return _localizedValues[locale.languageCode]!['caseBtn']!;
  }

  String get clinicBtn {
    return _localizedValues[locale.languageCode]!['clinicBtn']!;
  }

  String get caseFormTitle {
    return _localizedValues[locale.languageCode]!['caseFormTitle']!;
  }

  String get newCaseInputLabel {
    return _localizedValues[locale.languageCode]!['newCaseInputLabel']!;
  }

  String get newCaseInputHint {
    return _localizedValues[locale.languageCode]!['newCaseInputHint']!;
  }

  String get deathCaseInputLabel {
    return _localizedValues[locale.languageCode]!['deathCaseInputLabel']!;
  }

  String get deathCaseInputHint {
    return _localizedValues[locale.languageCode]!['deathCaseInputHint']!;
  }

  String get caseDateInputLabel {
    return _localizedValues[locale.languageCode]!['caseDateInputLabel']!;
  }

  String get caseDateInputHint {
    return _localizedValues[locale.languageCode]!['caseDateInputHint']!;
  }

  String get newCaseInputValidation {
    return _localizedValues[locale.languageCode]!['newCaseInputValidation']!;
  }

  String get deathCaseInputValidation {
    return _localizedValues[locale.languageCode]!['deathCaseInputValidation']!;
  }

  String get caseDateInputValidation {
    return _localizedValues[locale.languageCode]!['caseDateInputValidation']!;
  }

  String get addSuccessfullyButton {
    return _localizedValues[locale.languageCode]!['addSuccessfullyButton']!;
  }

  String get addFailedButton {
    return _localizedValues[locale.languageCode]!['addFailedButton']!;
  }

  String get caseID {
    return _localizedValues[locale.languageCode]!['caseID']!;
  }

  String get deathCase {
    return _localizedValues[locale.languageCode]!['deathCase']!;
  }

  String get newCase {
    return _localizedValues[locale.languageCode]!['newCase']!;
  }

  String get date {
    return _localizedValues[locale.languageCode]!['date']!;
  }

  String get dailyCasesDetails {
    return _localizedValues[locale.languageCode]!['dailyCasesDetails']!;
  }

  String get deleteSuccessfullyButton {
    return _localizedValues[locale.languageCode]!['deleteSuccessfullyButton']!;
  }

  String get deleteAlert {
    return _localizedValues[locale.languageCode]!['deleteAlert']!;
  }

  String get deleteBtn {
    return _localizedValues[locale.languageCode]!['deleteBtn']!;
  }

  String get confirmBtn {
    return _localizedValues[locale.languageCode]!['confirmBtn']!;
  }

  String get cancelBtn {
    return _localizedValues[locale.languageCode]!['cancelBtn']!;
  }

  String get updateBtn {
    return _localizedValues[locale.languageCode]!['updateBtn']!;
  }

  String get updateCaseDetails {
    return _localizedValues[locale.languageCode]!['updateCaseDetails']!;
  }

  String get caseUpdateFormTitle {
    return _localizedValues[locale.languageCode]!['caseUpdateFormTitle']!;
  }

  String get vaccinationCentres {
    return _localizedValues[locale.languageCode]!['vaccinationCentres']!;
  }

  String get totalDistance {
    return _localizedValues[locale.languageCode]!['totalDistance']!;
  }

  String get km {
    return _localizedValues[locale.languageCode]!['km']!;
  }
  String get availableVaccine {
    return _localizedValues[locale.languageCode]!['availableVaccine']!;
  }

  String get address {
    return _localizedValues[locale.languageCode]!['address']!;
  }

  String get hotline {
    return _localizedValues[locale.languageCode]!['hotline']!;
  }

  String get distance {
    return _localizedValues[locale.languageCode]!['distance']!;
  }

  String get deathCasesChartTitle {
    return _localizedValues[locale.languageCode]!['deathCasesChartTitle']!;
  }

  String get newCasesChartTitle {
    return _localizedValues[locale.languageCode]!['newCasesChartTitle']!;
  }

  String get deathCasesChartHeading {
    return _localizedValues[locale.languageCode]!['deathCasesChartHeading']!;
  }

  String get newCasesChartHeading {
    return _localizedValues[locale.languageCode]!['newCasesChartHeading']!;
  }

  String get startingPoint {
    return _localizedValues[locale.languageCode]!['startingPoint']!;
  }
  String get startMarker {
    return _localizedValues[locale.languageCode]!['startMarker']!;
  }
  String get destinationPoint {
    return _localizedValues[locale.languageCode]!['destinationPoint']!;
  }
  String get destinationMarker {
    return _localizedValues[locale.languageCode]!['destinationMarker']!;
  }

  String get addNewClinics{
    return _localizedValues[locale.languageCode]!['addNewClinics']!;
  }

  String get manageClinics{
    return _localizedValues[locale.languageCode]!['manageClinics']!;
  }

  String get clinicNameHint{
    return _localizedValues[locale.languageCode]!['clinicNameHint']!;
  }

  String get clinicNameLabel{
    return _localizedValues[locale.languageCode]!['clinicNameLabel']!;
  }

  String get requiredValidation{
    return _localizedValues[locale.languageCode]!['requiredValidation']!;
  }

  String get toolTip{
    return _localizedValues[locale.languageCode]!['toolTip']!;
  }

  String get addedSuccessfully{
    return _localizedValues[locale.languageCode]!['addedSuccessfully']!;
  }

  String get longitudeLabel{
    return _localizedValues[locale.languageCode]!['longitudeLabel']!;
  }


  String get longitudeHint{
    return _localizedValues[locale.languageCode]!['longitudeHint']!;
  }

  String get latitudeLabel{
    return _localizedValues[locale.languageCode]!['latitudeLabel']!;
  }

  String get latitudeHint{
    return _localizedValues[locale.languageCode]!['latitudeHint']!;
  }

  String get vaccineLabel{
    return _localizedValues[locale.languageCode]!['vaccineLabel']!;
  }

  String get vaccineHint{
    return _localizedValues[locale.languageCode]!['vaccineHint']!;
  }

  String get addressLabel{
    return _localizedValues[locale.languageCode]!['addressLabel']!;
  }

  String get addressHint{
    return _localizedValues[locale.languageCode]!['addressHint']!;
  }

  String get contactNoLabel{
    return _localizedValues[locale.languageCode]!['contactNoLabel']!;
  }

  String get contactNoHint{
    return _localizedValues[locale.languageCode]!['contactNoHint']!;
  }

  String get clinicID {
    return _localizedValues[locale.languageCode]!['clinicID']!;
  }


  String get clinicName {
    return _localizedValues[locale.languageCode]!['clinicName']!;
  }

  String get contactNo {
    return _localizedValues[locale.languageCode]!['contactNo']!;
  }

  String get vaccineBrand {
    return _localizedValues[locale.languageCode]!['vaccineBrand']!;
  }

  String get latitude {
    return _localizedValues[locale.languageCode]!['latitude']!;
  }

  String get longitude {
    return _localizedValues[locale.languageCode]!['longitude']!;
  }

  String get clinicDetails {
    return _localizedValues[locale.languageCode]!['clinicDetails']!;
  }

  String get updateClinicDetails {
    return _localizedValues[locale.languageCode]!['updateClinicDetails']!;
  }

  String get clinicUpdateFormTitle {
    return _localizedValues[locale.languageCode]!['clinicUpdateFormTitle']!;
  }


}
class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => DemoLocalizations.languages().contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
      DemoLocalizations.of(context).title,
      localizationsDelegates: const [
        DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ms', ''),
        Locale('zh', ''),
      ],
      title: 'Navigation Screens',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the homePage widget.
        '/': (context) => const HomePage(),
        '/admin': (context) =>  const AdminPage(),
        '/adminDashboard': (context) => const Admin_Dashboard(),
        '/adminClinicDashboard': (context) => const Admin_Clinic_Dashboard(),
        '/adminHomepage': (context) => const AdminHomePage(),
        '/publicUser': (context) => const MyGoogleMap(),
      },
    );
  }
}


