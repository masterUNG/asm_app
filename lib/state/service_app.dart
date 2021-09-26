import 'package:asm_app/body/home_screen.dart';
import 'package:asm_app/body/info_asm.dart';
import 'package:asm_app/body/info_house.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceApp extends StatefulWidget {
  const ServiceApp({Key? key}) : super(key: key);

  @override
  _ServiceAppState createState() => _ServiceAppState();
}

class _ServiceAppState extends State<ServiceApp> {
  int _selectedIndex = 0;
  String appbarTitleString = "หน้าหลัก";
  String? nameLogin;
  var appBarTitleText = new Text("หน้าหลัก");
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Index 0: หน้าหลัก',
      ),
    ),
    Text(
      'Index 1: ข้อมูลชุมชน',
    ),
    Text(
      'Index 2: ข้อมูล อสม.',
    ),
  ];

  List<Widget> _widgetOption = <Widget>[
    HomeScreen(),
    InfoHouse(),
    InfoASM(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        appbarTitleString = "หน้าหลัก";
        appBarTitleText = new Text(
          appbarTitleString,
          style: MyConstant().headStyle(),
        );
      } else if (index == 1) {
        appbarTitleString = "ข้อมูลชุมชน";
        appBarTitleText = new Text(
          appbarTitleString,
          style: MyConstant().headStyle(),
        );
      } else if (index == 2) {
        appbarTitleString = "ข้อมูล อสม.";
        appBarTitleText = new Text(
          appbarTitleString,
          style: MyConstant().headStyle(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: appBarTitleText,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeAuthen, (route) => false));
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'หน้าหลัก',
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.house_sharp),
          title: Text(
            'ข้อมูลชุมชน',
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          title: Text(
            'ข้อมูล อสม.',
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: MyConstant.primary, //สีตอนเลือกtap
      onTap: _onItemTap,
    );
  }
}
