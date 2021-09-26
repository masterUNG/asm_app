import 'package:asm_app/state/home/reportASM/report_asm.dart';
import 'package:asm_app/state/home/showdatareport/show_dataReport.dart';
import 'package:asm_app/state/home/showknow/show_know.dart';
import 'package:asm_app/state/home/shownews/show_news.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String? nameLogin, nameLoginOnHeader;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   findData();
  // }

  // Future<Null> findData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   List<String>? data = preferences.getStringList('data');

  //   String apiCheckUser =
  //       '${MyConstant.domain}/asm_api/getUserWhereUser.php?isAdd=true&user=${data![2]}';

  //   await Dio().get(apiCheckUser).then((value) {
  //     for (var item in json.decode(value.data)) {
  //       UserModel model = UserModel.fromMap(item);
  //       setState(() {
  //         nameLogin = data[1];
  //         nameLoginOnHeader = model.fullname;
  //       });
  //     }
  //   });
  // }
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
                  buildExpanded(context),
                ],
              ),
            ),
          ),
        ],
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