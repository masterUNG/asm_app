import 'dart:async';
import 'dart:convert';

import 'package:asm_app/models/patient_model.dart';
import 'package:asm_app/state/infoHouse/add_patient.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDataPatinetFromInfoHouse extends StatefulWidget {
  const ShowDataPatinetFromInfoHouse({Key? key}) : super(key: key);

  @override
  _ShowDataPatinetFromInfoHouseState createState() =>
      _ShowDataPatinetFromInfoHouseState();
}

class _ShowDataPatinetFromInfoHouseState
    extends State<ShowDataPatinetFromInfoHouse> {
  List<PatientModel> patientModels = [];
  List<PatientModel> searchDataPatient = [];
  final debouncer = Debouncer(millisecond: 500);
  bool loadStatus = true; // Process Load JSON
  bool status = true;

  @override
  void initState() {
    super.initState();
    showDataPatientFromServer();
  }

  Future<Null> showDataPatientFromServer() async {
    if (patientModels.length != 0) {
      patientModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    preferences.setString('patientId', '');

    String patientId = data![0];
    String apiShowDataPatient =
        '${MyConstant.domain}/asmApp_Api/getAllPatient.php?isAdd=true&patientId=$patientId';
    await Dio().get(apiShowDataPatient).then((value) async {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          PatientModel model = PatientModel.fromMap(item);
          List<String> data = [];
          data.add(model.patientId);
          setState(() {
            patientModels.add(model);
            searchDataPatient = patientModels;
          });
        }
      } else {
        setState(() {
          status
              ? showContent()
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
        appBar: AppBar(
          title: Text(
            '?????????????????????????????????????????????????????????????????????',
            style: MyConstant().textWidget2(),
          ),
          centerTitle: true,
          backgroundColor: MyConstant.primary,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildSearch(constraints),
                buildShowText(constraints),
                showContent(),
              ],
            ),
          ),
        ));
  }

  Widget showContent() {
    return status
        ? buildListResult()
        : Center(
            child: Text(
              '??????????????????????????????????????????',
              style: MyConstant().textWidget4(),
            ),
          );
  }

  Widget buildShowText(BoxConstraints constraints) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: constraints.maxWidth * 0.85,
          height: constraints.maxHeight * 0.10,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPatient(),
                ),
              ).then((value) => showDataPatientFromServer());
            },
            child: Text(
              '????????????????????????????????????????????????????????????????????????????????????',
              style: MyConstant().textWidget2(),
            ),
          ),
        ),
      );

  Padding buildSearch(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        onChanged: (value) {
          debouncer.run(() {
            setState(() {
              searchDataPatient = patientModels
                  .where((element) =>
                      element.fname.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          hintText: '???????????????',
          hintStyle: MyConstant().textWidget4(),
          labelStyle: MyConstant().textWidget4(),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildListResult() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: searchDataPatient.length,
          itemBuilder: (context, index) => Card(
            color: Colors.grey.shade100,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              // onTap: () async {
              //   SharedPreferences preferences =
              //       await SharedPreferences.getInstance();
              //   preferences.setString(
              //       'patientId', patientModels[index].patientId);
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ShowDetailInfoHouse(
              //         patientModel: patientModels[index],
              //       ),
              //       // builder: (context) => ShowDetailAddDataPatient(
              //       //   patientModel: patientModels[index],
              //       // ),
              //     ),
              //   ).then((value) => showDataPatientFromServer());
              // },
              leading: ShowImage(
                path: MyConstant.aosormor,
              ),
              title: Text(
                searchDataPatient[index].fname,
                style: MyConstant().textWidget3(),
              ),
              subtitle: Text(
                searchDataPatient[index].gender,
                style: MyConstant().textWidget4(),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ),
      );
}

class Debouncer {
  final int millisecond;
  Timer? timer;
  VoidCallback? callback;

  Debouncer({required this.millisecond});

  run(VoidCallback callback) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: millisecond), callback);
  }
}
