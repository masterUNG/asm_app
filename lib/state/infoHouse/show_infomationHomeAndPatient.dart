import 'dart:convert';

import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/patient_model.dart';
import 'package:asm_app/models/reportlooknam_model.dart';
import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/state/infoHouse/add_looknamReport.dart';
import 'package:asm_app/state/infoHouse/add_patient.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowInfoHomeAndPateint extends StatefulWidget {
  final HomeModel homelooknam;
  const ShowInfoHomeAndPateint({Key? key, required this.homelooknam})
      : super(key: key);

  @override
  _ShowInfoHomeAndPateintState createState() => _ShowInfoHomeAndPateintState();
}

class _ShowInfoHomeAndPateintState extends State<ShowInfoHomeAndPateint> {
  HomeModel? homelooknam;
  UserModel? userModel;
  PatientModel? patientModel;
  List<PatientModel> patientModels = [];
  List<HomeModel> homelooknams = [];
  List<HomeModel> homes = [];
  ReportLooknam? reportLooknam;
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
    print('homeId === $homeId');

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
    if (patientModels.length != 0) {
      patientModels.clear();
      loadStatus = true;
      status = true;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String homeId = preferences.getString('homeId')!;
    // String patientId = preferences.getString('patientId')!;
    // preferences.setString('staffId', '');
    // preferences.setString('homeId', '');
    // preferences.setString('patientId', '');

    String apiGetReportLooknam =
        '${MyConstant.domain}/asmApp_Api/show_dataPatientWhereId.php?isAdd=true&homeId=$homeId';
    await Dio().get(apiGetReportLooknam).then((value) {
      setState(() {
        loadStatus = false;
      });
      // print('value ==> $value');
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          PatientModel model = PatientModel.fromMap(item);
          setState(() {
            patientModels.add(model);
            userModel = UserModel.fromMap(item);
          });
        }
      } else {
        setState(() {
          status
              ? buildShowDataPatient()
              : Center(
                  child: Text(
                    '??????????????????????????????????????????',
                    style: MyConstant().textWidget4(),
                  ),
                );
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
            preferences.setString('homeId', home!.homeId);

            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPatient()))
                .then((value) => loadDetailFromAPI());
          }),
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          '?????????????????????????????????',
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
                      '????????????????????????: ${home!.hostNameTitle}${home!.hostFname}  ${home!.hostLname}',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      '?????????????????????????????????????????????????????????: ${home!.quantity}',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      '??????????????????????????????????????????. ????????????????????????????????????:',
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
        ? buildShowDataPatient()
        : Center(
            child: Text(
              '??????????????????????????????????????????',
              style: MyConstant().textWidget4(),
            ),
          );
  }

  ListView buildShowDataPatient() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: patientModels.length,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          title: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              children: <Widget>[
                Text(
                  '????????????-?????????????????????: ${patientModels[index].nameTitle}${patientModels[index].fname}  ${patientModels[index].lname}',
                  style: MyConstant().textWidget3(),
                ),
                Text(
                  '?????????: ${patientModels[index].gender}',
                  style: MyConstant().h3Style(),
                ),
                Text(
                  '?????????????????????????????????: ${patientModels[index].congenital}',
                  style: MyConstant().h1Style(),
                ),
                Text(
                  '???????????????????????????????????????: ${patientModels[index].typepatient}',
                  style: MyConstant().h1Style(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // IconButton(
                      //   onPressed: () {
                      //     MaterialPageRoute route = MaterialPageRoute(
                      //       builder: (context) => EditDataReportLooknam(
                      //         reportLooknam: reportlooknams[index],
                      //       ),
                      //     );
                      //     Navigator.push(context, route)
                      //         .then((value) => loadDetailFromAPI());
                      //   },
                      //   icon: Icon(
                      //     Icons.edit,
                      //     color: Colors.green,
                      //   ),
                      // ),
                      // IconButton(
                      //   onPressed: () =>
                      //       deleteData(reportlooknams[index].reportLooknamId),
                      //   icon: Icon(
                      //     Icons.delete,
                      //     color: Colors.red,
                      //   ),
                      // )
                    ],
                  ),
                )
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
              title: '????????????????????????????????????????????????????????????????????????????????????',
              textStyle: MyConstant().textWidget(),
            ),
            subtitle: ShowTitle(
                title: '?????????????????????????????????????????????????????????',
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
                      '??????????????????',
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
                      '??????????????????',
                      style: MyConstant().textWidget2(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
