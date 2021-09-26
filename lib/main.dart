import 'package:asm_app/state/authen.dart';
import 'package:asm_app/state/home/reportASM/report_asm.dart';
import 'package:asm_app/state/home/showdatareport/show_dataReport.dart';
import 'package:asm_app/state/home/showknow/show_know.dart';
import 'package:asm_app/state/home/shownews/show_news.dart';
import 'package:asm_app/state/service_app.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/serviceApp': (BuildContext context) => ServiceApp(),
  '/reportAsm': (BuildContext context) => ReportASM(),
  '/showKnow': (BuildContext context) => ShowKnow(),
  '/showNews': (BuildContext context) => ShowNews(),
  '/showDataReport': (BuildContext context) => ShowDataReport(),
  // '/showDataPatient': (BuildContext context) => ShowDataPatient(),
  // '/showDataHomeLookNam': (BuildContext context) => ShowDataHomeLooknam(),
  // '/AddPatient': (BuildContext context) => AddPatient(),
  // '/AddDataHealth': (BuildContext context) => AddDataHealth(),
};

String? firstState;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String>? data = preferences.getStringList('data');
  if (data == null) {
    firstState = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    firstState = MyConstant.routeServiceApp;
    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: firstState,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('th')],
    );
  }
}
