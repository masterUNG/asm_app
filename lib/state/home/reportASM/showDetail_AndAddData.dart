import 'dart:convert';

import 'package:asm_app/models/datahealth_model.dart';
import 'package:asm_app/models/patient_model.dart';
import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/state/home/reportASM/add_reportHealth.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailAndAddDataHealth extends StatefulWidget {
  final PatientModel patientModel;
  const ShowDetailAndAddDataHealth({Key? key, required this.patientModel})
      : super(key: key);

  @override
  _ShowDetailAndAddDataHealthState createState() =>
      _ShowDetailAndAddDataHealthState();
}

class _ShowDetailAndAddDataHealthState
    extends State<ShowDetailAndAddDataHealth> {
  PatientModel? patientModels;
  List<PatientModel> patientmodels = [];
  DataHealth? dataHealth;
  UserModel? userModel;
  List<DataHealth> dataHealths = [];
  String? staffId;

  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data

  var x = '';
  var result = '';
  var substring = '';

  @override
  void initState() {
    super.initState();
    patientModels = widget.patientModel;
    loadValueFromAPI();
    patientDataFromStaff();
    x = (patientModels!.congenital);
    String result = x.substring(1, x.length - 1);
    List<String> strings = result.split(',');
    // print(strings[0]);
    for (var item in strings) {
      substring += item + ",";
    }
    substring = substring.substring(0, substring.length - 1);
  }

  Future<Null> patientDataFromStaff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String patientId = preferences.getString('patientId')!;

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('staffId', '');

    String apiGetStaff =
        '${MyConstant.domain}/asm_api/show_PatientFromStaff.php?isAdd=true&patientId=$patientId';
    await Dio().get(apiGetStaff).then((value) {
      for (var item in json.decode(value.data)) {
        PatientModel model = PatientModel.fromMap(item);
        List<String> data = [];
        data.add(model.patientId);

        setState(() {
          patientmodels.add(model);
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  Future<Null> loadValueFromAPI() async {
    if (dataHealths.length != 0) {
      dataHealths.clear();
      loadStatus = true;
      status = true;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String patientId = preferences.getString('patientId')!;

    String apiGetDataHealth =
        '${MyConstant.domain}/asm_api/show_datahealth.php?isAdd=true&patientId=$patientId';
    await Dio().get(apiGetDataHealth).then((value) {
      setState(() {
        loadStatus = false;
      });
      // print('value ==> $value');
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          DataHealth model = DataHealth.fromMap(item);
          setState(() {
            dataHealths.add(model);
            userModel = UserModel.fromMap(item);
          });
          // print('pressure ===> ${model.pressure}');
        }
      } else {
        setState(() {
          status
              ? buildShowDataHealth()
              : Center(
                  child: Text(
                    'ยังไม่มีข้อมูล',
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
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'ข้อมูลผู้ป่วย ${patientModels!.fname}',
          style: MyConstant().textWidget2(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('patientId', patientModels!.patientId);
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddReportHealth()))
              .then((value) => loadValueFromAPI());
        },
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
                          buildDataPatient(),
                          showContent(),
                        ],
                      ),
                    ),
                  ),
                ),

          // showContent(),
          // buildDataPatient()
        ],
      ),
    );
  }

  Widget showContent() {
    return status
        ? buildShowDataHealth()
        : Center(
            child: Text(
              'ยังไม่มีข้อมูล',
              style: MyConstant().textWidget4(),
            ),
          );
  }

  Widget buildDataPatient() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Container(
                margin: EdgeInsets.only(top: 5.0),
                padding: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  children: <Widget>[
                    Text(
                      'เพศ: ${patientModels!.gender}',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      'เบอร์โทร: ${patientModels!.tell}',
                      style: MyConstant().textWidget3(),
                    ),
                    // Text('ที่อยู่: ${patientModels!.address}'),
                    Text(
                      'โรคประจำตัว: $substring',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      'ประเภทผู้ป่วย: ${patientModels!.typepatient}',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      'เจ้าหน้าที่อสม. ที่ดูแล:',
                      style: MyConstant().textWidget3(),
                    ),
                    Text(
                      '${userModel!.firstname}',
                      style: MyConstant().textWidget3(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView buildShowDataHealth() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: dataHealths.length,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          title: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              children: <Widget>[
                Text(
                  'เจ้าหน้าที่บันทึกข้อมูล: ${userModel!.firstname}',
                  style: MyConstant().textWidget3(),
                ),
                Text(
                  'วันที่บันทึก: ${dataHealths[index].dateTime}',
                  style: MyConstant().textWidget3(),
                ),
                Row(
                  children: [
                    Text(
                      'ความดัน: ${dataHealths[index].pressure}',
                      style: MyConstant().textWidget3(),
                    ),
                  ],
                ),
                Row(children: [
                  Text(
                    'ค่าน้้ำตาล: ${dataHealths[index].bloodsugar}',
                    style: MyConstant().textWidget3(),
                  ),
                ]),
                Row(
                  children: [
                    Text(
                      'อาการอื่น ๆ: ${dataHealths[index].details}',
                      style: MyConstant().textWidget3(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'หมายเหตุ: ${dataHealths[index].note}',
                      style: MyConstant().textWidget3(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> deleteData(String id) async {
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
                        print(
                            '#### confirm Delete ===> ${dataHealth!.reportHealthId}');
                        String apiDelete =
                            '${MyConstant.domain}/asm_api/deleteDataHealthWhereId.php?isAdd=true&id=$id';
                        await Dio().get(apiDelete).then((value) {
                          Navigator.pop(context);
                          loadValueFromAPI();
                        });
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
