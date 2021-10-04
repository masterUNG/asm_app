import 'dart:async';
import 'dart:convert';

import 'package:asm_app/models/congenital_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCongenitalPatient extends StatefulWidget {
  const AddCongenitalPatient({Key? key}) : super(key: key);

  @override
  _AddCongenitalPatientState createState() => _AddCongenitalPatientState();
}

class _AddCongenitalPatientState extends State<AddCongenitalPatient> {
  List<CongenitalModel> congenitalModels = [];
  List<CongenitalModel> searchCongenitals = [];
  final debouncers = Debouncer(millisecond: 500);

  bool loadStatus = true; // Process Load JSON
  bool status = true;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    showDataAllCongenital();
  }

  Future<Null> showDataAllCongenital() async {
    if (congenitalModels.length != 0) {
      congenitalModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    preferences.setString('congenitalId', '');
    String congenitalId = data![0];

    String apiShowAllHome =
        '${MyConstant.domain}/asmApp_Api/getAllCongenital.php?isAdd=true&congenitalId=$congenitalId';
    await Dio().get(apiShowAllHome).then((value) async {
      for (var item in json.decode(value.data)) {
        CongenitalModel model = CongenitalModel.fromMap(item);
        List<String> data = [];
        data.add(model.congenitalId);
        setState(() {
          congenitalModels.add(model);
          searchCongenitals = congenitalModels;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลโรคประจำตัว',
          style: MyConstant().textWidget2(),
        ),
        backgroundColor: MyConstant.primary,
        centerTitle: true,
      ),
      body: congenitalModels.length == 0
          ? ShowProgress()
          : LayoutBuilder(
              builder: (context, constraints) => GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      buildSearch(constraints),
                      showContent(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildSearch(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        onChanged: (value) {
          debouncers.run(() {
            setState(() {
              searchCongenitals = congenitalModels
                  .where((element) => element.congenitalName
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          hintText: 'ค้นหา',
          hintStyle: MyConstant().textWidget4(),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget showContent() {
    return status
        ? buildListResult()
        : Center(
            child: Text(
              'ยังไม่มีข้อมูล',
              style: MyConstant().textWidget4(),
            ),
          );
  }

  Widget buildListResult() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: searchCongenitals.length,
          itemBuilder: (context, index) => InkWell(
            child: Card(
              color: Colors.grey.shade100,
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                leading: ShowImage(
                  path: MyConstant.aosormor,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      searchCongenitals[index].congenitalName,
                      style: MyConstant().textWidget3(),
                    )
                  ],
                ),
                onTap: () {
                  if (isSelected == true) {
                    showDialog(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SimpleDialog(
                          title: ListTile(
                            leading: ShowImage(path: MyConstant.aosormor),
                            title: ShowTitle(
                              title: 'คุณต้องการเลือกข้อมูลนี้ใช่หรือไม่',
                              textStyle: MyConstant().textWidget(),
                            ),
                            subtitle: ShowTitle(
                                title: 'กดตกลงเพื่อบันทึกข้อมูล',
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
                                      Map<String, dynamic> map = {};
                                      map['index'] = index;
                                      map['congenitalId'] =
                                          congenitalModels[index].congenitalId;
                                      map['congenitalName'] =
                                          congenitalModels[index]
                                              .congenitalName;

                                      print('### map ที่ส่งกลับไป ===> $map');
                                      Navigator.pop(context, map);
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
                        ),
                      ),
                    );
                  }
                },
              ),
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
