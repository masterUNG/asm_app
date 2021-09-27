import 'dart:convert';

import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/state/home/reportASM/report_asm.dart';
import 'package:asm_app/state/home/showdatareport/show_dataReport.dart';
import 'package:asm_app/state/home/showknow/show_know.dart';
import 'package:asm_app/state/home/shownews/show_news.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? nameLogin, showTitleName, showUsername, showlname, id, showAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findData();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');

    String apiCheckUser =
        '${MyConstant.domain}/asmApp_Api/getUserWhereUser.php?isAdd=true&usernames=${data![2]}';
    await Dio().get(apiCheckUser).then((value) {
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          nameLogin = data[1];
          showTitleName = model.nameTitles;
          showUsername = model.firstname;
          showlname = model.lastname;
          showAddress = model.address;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // drawerHeader(),
                  buildCardName(context),
                  buildExpanded(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildCardName(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/aorsormor.png'),
                  radius: 32,
                ),
              ),
              Text(
                '$showTitleName',
                style: MyConstant().textWidget3(),
              ),
              // Container(
              //   child: Text(
              //     '${showUsername!}',
              //     style: MyConstant().textWidget3(),
              //   ),
              // ),
              Text(
                '$nameLogin',
                style: MyConstant().textWidget3(),
              ),
              Text(
                '$showlname',
                style: MyConstant().textWidget3(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
        child: GridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            children: <Widget>[
              // รายงานอสม
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyConstant.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportASM()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.local_hospital_rounded,
                        size: 50,
                        color: Colors.brown,
                      ),
                      Text(
                        'รายงาน อสม.',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 18,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              // ดูรายงาน อสม.
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyConstant.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowDataReport()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.ballot_rounded,
                        size: 50,
                        color: Colors.brown,
                      ),
                      Text(
                        'ดูรายงาน อสม.',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 18,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              // กระดานข่าว
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyConstant.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowNews()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.ballot_rounded,
                        size: 50,
                        color: Colors.brown,
                      ),
                      Text(
                        'กระดานข่าว',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 18,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              //  คลังความรู้
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyConstant.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowKnow()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.perm_media_rounded,
                        size: 50,
                        color: Colors.brown,
                      ),
                      Text(
                        'คลังความรู้',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 18,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              //ออกจากระบบ
            ],
            crossAxisCount: 2));
  }
}
