import 'dart:convert';

import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/reportlooknam_model.dart';
import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/state/infoHouse/add_looknamReport.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowInfoHomeLooknam extends StatefulWidget {
  final HomeModel homelooknam;
  const ShowInfoHomeLooknam({Key? key, required this.homelooknam})
      : super(key: key);

  @override
  _ShowInfoHomeLooknamState createState() => _ShowInfoHomeLooknamState();
}

class _ShowInfoHomeLooknamState extends State<ShowInfoHomeLooknam> {
  HomeModel? homelooknam;
  UserModel? userModel;
  List<HomeModel> homelooknams = [];
  List<HomeModel> homes = [];
  List<ReportLooknam> reportlooknams = [];
  HomeModel? home;
  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data
  String? sum;
  String? total;
  String? amount;
  String? dateTime;

  @override
  void initState() {
    super.initState();
    home = widget.homelooknam;
    loadDetailFromAPI();
    loadHomeFromStaff();
  }

  Future<Null> loadHomeFromStaff() async {
    if (homes.length != 0) {
      homes.clear();
      loadStatus = true;
      status = true;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String homeId = preferences.getString('homeId')!;
    String userId = preferences.getString('userId')!;
    print('staffid login === $userId');

    String apiGetValue =
        '${MyConstant.domain}/asmApp_Api/show_HomeLooknamWhereId.php?isAdd=true&homeId=$homeId';
    await Dio().get(apiGetValue).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          HomeModel model = HomeModel.fromMap(item);
          setState(() {
            homes.add(model);
            userModel = UserModel.fromMap(item);
          });
          // print('pressure ===> ${model.pressure}');
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Future<Null> loadDetailFromAPI() async {
    if (reportlooknams.length != 0) {
      reportlooknams.clear();
      loadStatus = true;
      status = true;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String homeId = preferences.getString('homeId')!;

    String apiGetReportLooknam =
        '${MyConstant.domain}/asmApp_Api/show_dataHomeLooknam.php?isAdd=true&homeId=$homeId';
    await Dio().get(apiGetReportLooknam).then((value) {
      setState(() {
        loadStatus = false;
      });
      // print('value ==> $value');
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          // HomeLooknam model = HomeLooknam.fromMap(item);
          ReportLooknam model = ReportLooknam.fromMap(item);
          setState(() {
            reportlooknams.add(model);
            userModel = UserModel.fromMap(item);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('homeid', home!.homeId);

            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddLooknamReport()))
                .then((value) => loadDetailFromAPI());
          }),
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'ข้อมูลพื้นที่สำรวจลูกน้ำยุงลาย',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          loadStatus
              ? ShowProgress()
              : LayoutBuilder(
                  builder: (context, constrints) => GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    behavior: HitTestBehavior.opaque,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          buildDataHome(),
                          showContent(),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildDataHome() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
          // color: Colors.deepPurpleAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'เจ้าบ้าน: ${home!.hostNameTitle}${home!.hostFname}  ${home!.hostLname}',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      'จำนวนผู้อาศัยในบ้าน: ${home!.quantity}',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      'เจ้าหน้าที่อสม. ที่รับผิดชอบ:',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      '${userModel!.nameTitles}${userModel!.firstname}   ${userModel!.lastname}',
                      style: MyConstant().textWidget3(),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget showContent() {
    return status
        ? buildShowDataLooknam()
        : Center(
            child: Text(
              'ยังไม่มีข้อมูล',
              style: MyConstant().textWidget4(),
            ),
          );
  }

  ListView buildShowDataLooknam() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: reportlooknams.length,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          title: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: <Widget>[
                Text(
                  'เจ้าหน้าที่บันทึกข้อมูล: ${userModel!.firstname}',
                  style: MyConstant().textWidget3(),
                ),
                Text(
                  'วันที่บันทึกข้อมูล: ${reportlooknams[index].dateTime}',
                  style: MyConstant().h3Style(),
                ),
                Text('CI ${reportlooknams[index].sum}%',
                    style: MyConstant().h1Style()),
                Text(
                  '(ดัชนีความชุกลูกน้ำยุงลายที่พบในบ้าน)',
                  style: MyConstant().h3Style(),
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.green[800])),
                    Padding(
                      padding: EdgeInsets.all(6),
                    ),
                    Expanded(child: Divider(color: Colors.green[800])),
                  ],
                ),
                Text(
                  'สำรวจทั้งหมด ${reportlooknams[index].total} ภาชนะ',
                  style: MyConstant().h2Style(),
                ),
                Text(
                  'จุดที่พบลูกน้ำ ${reportlooknams[index].amount} ภาชนะ',
                  style: MyConstant().h2Style(),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       IconButton(
                //         onPressed: () {
                //           MaterialPageRoute route = MaterialPageRoute(
                //             builder: (context) => EditDataReportLooknam(
                //               reportLooknam: reportlooknams[index],
                //             ),
                //           );
                //           Navigator.push(context, route)
                //               .then((value) => loadDetailFromAPI());
                //         },
                //         icon: Icon(
                //           Icons.edit,
                //           color: Colors.green,
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () =>
                //             deleteData(reportlooknams[index].reportId),
                //         icon: Icon(
                //           Icons.delete,
                //           color: Colors.red,
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> deleteData(String reportId) async {
    showDialog(
      context: context,
      builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SimpleDialog(
            title: ListTile(
              leading: ShowImage(path: MyConstant.aosormor),
              title: ShowTitle(
                title: 'คุณต้องการลบข้อมูลใช่หรือไม่',
                textStyle: MyConstant().textWidget(),
              ),
              subtitle: ShowTitle(
                  title: 'กดตกลงเพื่อลบข้อมูล',
                  textStyle: MyConstant().h3Style()),
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'ยกเลิก',
                        style: MyConstant().textWidget2(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        // Navigator.pop(context);
                        String apiDelete =
                            '${MyConstant.domain}/asm_api/deleteReportLooknamWhereId.php?isAdd=true&reportId=$reportId';
                        await Dio().get(apiDelete).then((value) {
                          Navigator.pop(context);
                          loadDetailFromAPI();
                        });
                        print('delete ==> $apiDelete ');
                      },
                      child: Text(
                        'ยืนยัน',
                        style: MyConstant().textWidget2(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
