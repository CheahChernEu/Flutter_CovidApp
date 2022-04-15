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
      'addButton': 'Added Successfully!',

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
      'addButton': 'Berjaya Ditambahkan!',
    },

    'zh': {
      'title': 'Covid_App 主页',
      'message': '保持健康！防止新冠病毒',
      'adminBtn': '管理员',
      'clientBtn': '客户',
      'loginTitle': '欢迎来到 Covid_App',
      'loginMessage': '我们提供最好的 Covid-19 服务\n永远快乐',
      'loginHeading': '登入 Covid_App',
      'loginEmail': '填入您的邮件地址',
      'loginPw': '填入您的密码',
      'emailValidation': '请填入正确的邮件地址',
      'pwValidation': '请填入正确的密码',
      'loginText': '登入',
      'successfulLoginAlert': '成功登入！',
      'failedLoginAlert': '登入失败 -- 请重试！',
      'adminHomepageTitle': '管理员主页',
      'caseBtn': '每日病例管理',
      'clinicBtn': '诊所管理',
      'caseFormTitle': '每日病例提交表',
      'newCaseInputLabel': '填入每日新增病例',
      'newCaseInputHint': '例如 10000',
      'newCaseInputValidation': '请填入正确的每日新增病例',
      'deathCaseInputLabel': '填入每日死亡病例',
      'deathCaseInputHint': '例如 100',
      'deathCaseInputValidation': '请填入正确的每日死亡病例',
      'caseDateInputLabel': '填入每日病例日期',
      'caseDateInputHint': '例如 2022-08-12',
      'caseDateInputValidation': '请填入正确的日期',
      'addButton': '添加成功！',
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

  String get addButton {
    return _localizedValues[locale.languageCode]!['addButton']!;
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
        // '/third': (context) => const ThirdPageForm(),
        // '/fourth': (context) => const FourthPageForm()
      },
    );
  }
}


