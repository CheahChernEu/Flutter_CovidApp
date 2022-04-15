import 'package:covid_app/adminClinicDashboard.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'homepage.dart';
import 'adminDashboard.dart';
import 'adminHomepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
// import 'SecondRoutePage.dart';

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
      'title': 'Hello World',
      'message': 'Stay Healthy! Prevent Covid-19!'
    },
    'es': {
      'title': 'Hola Mundo',
      'message': 'Ini app pertama saya'
    },
  };

  static List<String> languages ()=> _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get message {
    return _localizedValues[locale.languageCode]!['message']!;
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
        Locale('es', ''),
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
        // '/third': (context) => const ThirdPageForm(),
        // '/fourth': (context) => const FourthPageForm()
      },
    );
  }
}


