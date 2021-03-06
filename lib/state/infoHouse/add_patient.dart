import 'dart:async';
import 'dart:convert';

import 'package:asm_app/models/congenital_model.dart';
import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/patient_model.dart';
import 'package:asm_app/state/infoHouse/add_congenitalPatient.dart';
import 'package:asm_app/state/infoHouse/add_homePatient.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
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
  // String? congenital;
  String? typepatient;
  String? dateTime;

  String? hostLname;
  String? houseNo;
  String? villageNo;
  String? village;
  String? subDistrictId;
  String? districtId;
  String? provinceId;
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

  // ????????????????????????
  String? valueChoose;
  List listItem = ['?????????', '?????????', '??????????????????', '????????????????????????', '?????????????????????'];
  String dropdownValue = '?????????';

  int currentStep = 0;
  bool isCompleted = false;

  // ???????????????????????????????????????
  String? typept;
  List listItempt = ['??????????????????', '????????????????????????', '??????????????????????????????', '?????????????????????????????????????????????'];
  String dropdownValuept = '??????????????????';

// ?????????????????????????????????
  CongenitalModel? congenitals;
  String? listCongenital;
  String myValue = '?????????????????????????????????';
  List<CongenitalModel> congenital = [];
  List<CongenitalModel> listcongenital = [];

  Future showCongenital() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    preferences.setString('congenitalId', '');
    String congenitalId = data![0];

    String apiShowCongenital =
        '${MyConstant.domain}/asmApp_Api/getAllCongenital.php?isAdd=true&congenitalId=$congenitalId';

    await Dio().get(apiShowCongenital).then((value) {
      List<String> data = [];
      for (var item in json.decode(value.data)) {
        CongenitalModel model = CongenitalModel.fromMap(item);
        data.add(model.congenitalId);
        setState(() {
          congenital.add(model);
        });
      }
    });
  }

  ScrollController scrollController = ScrollController();
  int searchHomeListView = 1;

  @override
  void initState() {
    super.initState();
    showDataHomeFromServer();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          searchHomeListView = searchHomeListView + 1;
        });
      }
    });
    showCongenital();
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
        backgroundColor: MyConstant.primary,
        title: Text(
          '??????????????????????????????????????????????????????????????????',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: isCompleted
          ? buildCompleted()
          : Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  setState(() => isCompleted = true);
                  print('completeeee');
                  // send Data to Server
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepTapped: (step) => setState(() => currentStep = step),
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
              controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: onStepContinue,
                          child: Text(
                            isLastStep ? '????????????' : '???????????????',
                            style: MyConstant().textWidget2(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: onStepCancel,
                            child: Text(
                              '????????????',
                              style: MyConstant().textWidget2(),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // Widget showContent() {
  //   return status
  //       ? buildResultSearchAddress()
  //       : Center(
  //           child: Text(
  //             '??????????????????????????????????????????',
  //             style: MyConstant().textWidget4(),
  //           ),
  //         );
  // }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            '???????????????????????????????????????',
            style: MyConstant().textWidget5(),
          ),
          content: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Container(
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          buildNamesTitle(constraints),
                          buildFNames(constraints),
                          buildLNames(constraints),
                          buildGender(constraints),
                          buildBirthday(constraints),
                          buildWeightAndHeight(constraints),
                          // buildHeight(constraints),
                          buildTell(constraints),
                          // buildSearchAddress(constraints),
                          // buildResultSearchAddress(),
                          // buildHouseNo(constraints),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(
            '???????????????????????????????????????????????????',
            style: MyConstant().textWidget5(),
          ),
          content: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          buildcongenital(constraints),
                          buildTypePatient(constraints)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text(
            '???????????????????????????????????????',
            style: MyConstant().textWidget5(),
          ),
          content: Container(),
        ),
      ];

  Widget buildTypePatient(BoxConstraints constraints) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
              '???????????????????????????????????????',
              style: MyConstant().textWidget3(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: constraints.maxWidth * 0.95,
            child: DropdownButton<String>(
              value: dropdownValuept,
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
                  dropdownValuept = newValue!;
                });
              },
              items: <String>['??????????????????', '????????????????????????', '?????????????????????', '?????????????????????????????????']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: MyConstant().textWidget3(),
                  ),
                );
              }).toList(),
              // items: <String>['??????????????????', '????????????????????????', '?????????????????????', '?????????????????????????????????']
              //     .map<DropdownMenuItem<String>>((String value) {
              //   return DropdownMenuItem<String>(
              //     value: value,
              //     child: Text(
              //       value,
              //       style: MyConstant().textWidget3(),
              //     ),
              //   );
              // }).toList(),
            ),
          ),
        ]);
  }
// ??????????????????????????????????????????????????????????????? 
  Widget buildcongenital(BoxConstraints constraints) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
              '?????????????????????????????????',
              style: MyConstant().textWidget3(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: constraints.maxWidth * 0.95,
            child: DropdownButton<String>(
              value: myValue,
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
                  myValue = newValue!;
                  showCongenital();
                  print(myValue);
                });
              },
              items: <CongenitalModel>[]
                  .map<DropdownMenuItem<String>>((CongenitalModel value) {
                return DropdownMenuItem<String>(
                  value: listCongenital,
                  child: Text(
                    '${congenitals!.congenitalName}',
                    style: MyConstant().textWidget3(),
                  ),
                );
              }).toList(),

              // items: <String>['??????????????????', '????????????????????????', '?????????????????????', '?????????????????????????????????']
              //     .map<DropdownMenuItem<String>>((String value) {
              //   return DropdownMenuItem<String>(
              //     value: value,
              //     child: Text(
              //       value,
              //       style: MyConstant().textWidget3(),
              //     ),
              //   );
              // }).toList(),
            ),
          ),
        ]);
  }

  Widget buildHouseNo(BoxConstraints constraints) {
    return Column(
      children: <Widget>[
        Container(
          width: constraints.maxWidth * 0.95,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchAndAddHomePatient(),
                  ),
                ).then((value) {
                  print('### value ===> $value');
                });
              },
              child: Text(
                '??????????????????????????????????????? ',
                style: MyConstant().textWidget2(),
              ),
            ),
          ),
        ),
        Text('data ')
      ],
    );
  }

  Widget buildTell(BoxConstraints constraints) {
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
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '?????????????????????????????????????????????????????????????????????????????????';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: '??????????????????????????????????????? :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.phone),
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

  Row buildWeightAndHeight(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16, right: 5),
          width: constraints.maxWidth * 0.45,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: weightController,
            style: MyConstant().textWidget3(),
            validator: (value) {
              if (value!.isEmpty) {
                return '?????????????????????????????????????????????????????????????????????????????????';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: '????????????????????? :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(
                Icons.face_outlined,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.45,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: MyConstant().textWidget3(),
            controller: heightController,
            validator: (value) {
              if (value!.isEmpty) {
                return '?????????????????????????????????????????????????????????????????????????????????';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: '????????????????????? :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(
                Icons.face_outlined,
              ),
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
                      '?????????/???????????????/??????????????????',
                      style: MyConstant().textWidget4(),
                    ),
                  ),
                  Text(
                    _dateTime == null
                        ? '????????????????????????????????????????????????????????????????????????'
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
                    title: '????????? : ', textStyle: MyConstant().textWidget3()),
                SizedBox(
                  width: 30,
                ),
                Radio(
                  value: '?????????',
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
                  title: '?????????',
                  textStyle: MyConstant().textWidget3(),
                ),
                SizedBox(
                  width: 30,
                ),
                Radio(
                  value: '????????????',
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
                  title: '????????????',
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

  Widget buildLNames(BoxConstraints constraints) {
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
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '?????????????????????????????????????????????????????????????????????????????????';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: '????????????????????? :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.face_outlined),
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

  Widget buildFNames(BoxConstraints constraints) {
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
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    controller: addressController,
                    style: MyConstant().textWidget3(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '?????????????????????????????????????????????????????????????????????????????????';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: '???????????? :',
                      labelStyle: MyConstant().textWidget4(),
                      prefixIcon: Icon(Icons.face_outlined),
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

  Widget buildNamesTitle(BoxConstraints constraints) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: constraints.maxWidth * 0.35,
            child: Text(
              '????????????????????????????????????',
              style: MyConstant().textWidget3(),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: 5),
            width: constraints.maxWidth * 0.35,
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
              items: <String>['?????????', '?????????', '??????????????????', '????????????????????????', '?????????????????????']
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
          ),
        ]);
  }

  buildCompleted() {}
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
