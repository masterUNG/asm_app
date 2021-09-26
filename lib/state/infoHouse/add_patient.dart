import 'dart:async';
import 'dart:convert';

import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/patient_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  PatientModel? patientModel;
  String? patientId;
  String? staffId;
  String? nameTitle;
  String? fname;
  String? lname;
  String? gender;
  String? birthday;
  String? weight;
  String? height;
  String? tell;
  String? address;
  String? congenital;
  String? typepatient;
  String? dateTime;
  DateTime? _dateTime;
  final format = DateFormat("yyyy-MM-dd");
  final formkey = GlobalKey<FormState>();
  TextEditingController fnamesController = TextEditingController();
  TextEditingController lnamesController = TextEditingController();
  TextEditingController tellController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController congenitalController = TextEditingController();
  TextEditingController drugallergicController = TextEditingController();
  TextEditingController foodallergyController = TextEditingController();
  TextEditingController typepatientController = TextEditingController();

  List<HomeModel> homeModel = [];
  List<HomeModel> searchHome = [];
  final debouncer = Debouncer(millisecond: 500);
  bool loadStatus = true; // Process Load JSON
  bool status = true;

  String? valueChoose;
  List listItem = ['นาย', 'นาง', 'นางสาว', 'อื่น ๆ'];
  String dropdownValue = 'นาย';

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    showDataHomeFromServer();
  }

  Future<Null> showDataHomeFromServer() async {
    if (homeModel.length != 0) {
      homeModel.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    preferences.setString('homeId', '');
    String homeId = data![0];
    String apiShowHomeData =
        '${MyConstant.domain}/asmApp_Api/getAllHome.php?isAdd=true&homeId=$homeId';
    await Dio().get(apiShowHomeData).then((value) async {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          HomeModel model = HomeModel.fromMap(item);
          List<String> data = [];
          data.add(model.homeId);
          setState(() {
            homeModel.add(model);
            searchHome = homeModel;
          });
        }
      } else {
        setState(() {
          status
              ? Center(
                  child: Text('data'),
                )
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
          'เพิ่มผู้ป่วยภายในชุมชน',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            print('completeeee');
            // send Data to Server
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel:
            currentStep == 0 ? null : () => setState(() => currentStep -= 1),
      ),
    );
  }

  // Widget showContent() {
  //   return status
  //       ? buildResultSearchAddress()
  //       : Center(
  //           child: Text(
  //             'ยังไม่มีข้อมูล',
  //             style: MyConstant().textWidget4(),
  //           ),
  //         );
  // }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text(
            'ข้อมูลส่วนตัว',
            style: MyConstant().textWidget5(),
          ),
          content: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      buildNamesTitle(constraints),
                      buildNames(constraints),
                      buildGender(constraints),
                      buildBirthday(constraints),
                      buildWeight(constraints),
                      buildHeight(constraints),
                      buildTell(constraints),
                      // buildSearchAddress(constraints),
                      // buildResultSearchAddress(),
                      buildHouseNoAndVillageNo(constraints),
                      buildVillageAndsubDistrict(constraints),
                      // buildVillageNo(constraints),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text(
            'ข้อมูลโรคประจำตัว',
            style: MyConstant().textWidget5(),
          ),
          content: Container(),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text(
            'ตรวจสอบข้อมูล',
            style: MyConstant().textWidget5(),
          ),
          content: Container(),
        ),
      ];

  Widget buildVillageAndsubDistrict(BoxConstraints constraints) {
    return Container(
      // margin: const EdgeInsets.only(left: 50),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16, right: 5),
                  width: constraints.maxWidth * 0.45,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'บ้าน :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.home_filled),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: MyConstant.dark),
                      //   borderRadius: BorderRadius.circular(30),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyConstant.light),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: constraints.maxWidth * 0.45,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'ตำบล :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.home_filled),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: MyConstant.dark),
                      //   borderRadius: BorderRadius.circular(30),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyConstant.light),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildHouseNoAndVillageNo(BoxConstraints constraints) {
    return Container(
      // margin: const EdgeInsets.only(left: 50),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16, right: 5),
                  width: constraints.maxWidth * 0.45,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'บ้านเลขที่ :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.home_filled),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: MyConstant.dark),
                      //   borderRadius: BorderRadius.circular(30),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyConstant.light),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: constraints.maxWidth * 0.45,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'หมู่ที่ :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.home_filled),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: MyConstant.dark),
                      //   borderRadius: BorderRadius.circular(30),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyConstant.light),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildTell(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: tellController,
            style: MyConstant().textWidget3(),
            maxLength: 10,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: 'xx-xxxxxxxx',
              labelText: 'เบอร์โทรศัพท์ :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(Icons.phone),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildHeight(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: MyConstant().textWidget3(),
            controller: heightController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'ส่วนสูง :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(
                Icons.face_outlined,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildWeight(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: weightController,
            style: MyConstant().textWidget3(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'น้ำหนัก :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(
                Icons.face_outlined,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildBirthday(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Container(
              width: constraints.maxWidth * 0.75,
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        locale: const Locale("th", "TH"),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2025),
                      ).then((date) {
                        setState(() {
                          _dateTime = date;
                        });
                      });
                    },
                    child: Text(
                      'วัน/เดือน/ปีเกิด',
                      style: MyConstant().textWidget4(),
                    ),
                  ),
                  Text(
                    _dateTime == null
                        ? 'กรุณาเลือกวันเดือนปีเกิด'
                        : '${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day}',
                    style: MyConstant().textWidget3(),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget buildGender(BoxConstraints constraints) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ShowTitle(
                    title: 'เพศ : ', textStyle: MyConstant().textWidget3()),
                SizedBox(
                  width: 30,
                ),
                Radio(
                  value: 'ชาย',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(
                      () {
                        gender = value as String?;
                      },
                    );
                  },
                ),
                ShowTitle(
                  title: 'ชาย',
                  textStyle: MyConstant().textWidget3(),
                ),
                SizedBox(
                  width: 30,
                ),
                Radio(
                  value: 'หญิง',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(
                      () {
                        gender = value as String?;
                      },
                    );
                  },
                ),
                ShowTitle(
                  title: 'หญิง',
                  textStyle: MyConstant().textWidget3(),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildNames(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            style: MyConstant().textWidget3(),
            controller: fnamesController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'ชื่อ-นามสกุล :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(
                Icons.face_outlined,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildNamesTitle(BoxConstraints constraints) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 5),
        width: constraints.maxWidth * 0.45,
        child: DropdownButton(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['นาย', 'นาง', 'นางสาว', 'อื่น ๆ']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: MyConstant().textWidget3(),
              ),
            );
          }).toList(),
        ),
      )
    ]);
  }
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
