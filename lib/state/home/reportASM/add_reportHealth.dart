import 'dart:io';
import 'dart:math';

import 'package:asm_app/models/datahealth_model.dart';
import 'package:asm_app/models/patient_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/utility/my_dialog.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReportHealth extends StatefulWidget {
  const AddReportHealth({Key? key}) : super(key: key);

  @override
  _AddReportHealthState createState() => _AddReportHealthState();
}

class _AddReportHealthState extends State<AddReportHealth> {
  final formkey = GlobalKey<FormState>();
  List<File?> files = [];
  File? file;
  TextEditingController pressureController = TextEditingController();
  TextEditingController bloodsugarController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<String> paths = [];
  DataHealth? dataHealth;
  PatientModel? patientModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 1; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'บันทึกข้อมูลการตรวจสุขภาพ',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Center(
                child: Column(
                  children: [
                    buildPressure(constraints),
                    buildBloodSugar(constraints),
                    buildDetails(constraints),
                    buildNote(constraints),
                    buildImage(constraints),
                    buildAddDataButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddDataButton(BoxConstraints constraints) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          margin: EdgeInsets.only(top: 25, bottom: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: ListTile(
                  leading: ShowImage(path: MyConstant.aosormor),
                  title: ShowTitle(
                      title: 'กดตกลงเพื่อบันทึกข้อมูล',
                      textStyle: MyConstant().textWidget()),
                  subtitle: ShowTitle(
                      title: 'กรุณาตรวจสอบข้อมูลก่อนกดบันทึกข้อมูล',
                      textStyle: MyConstant().h3Style()),
                ),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'ยกเลิก',
                            style: MyConstant().textWidget2(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          // onPressed: () => processUploadAnInsertData(),
                          onPressed: () {
                            Navigator.pop(context);
                            processUploadAnInsertData();
                          },
                          child:
                              Text('ยืนยัน', style: MyConstant().textWidget2()),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            child: Text(
              'บันทึกข้อมูล',
              style: MyConstant().textWidget2(),
            ),
          ),
        ),
      );

  Future<Null> processUploadAnInsertData() async {
    if (formkey.currentState!.validate()) {
      bool checkFile = true;
      for (var item in files) {
        if (item == null) {
          checkFile = false;
        }
      }

      if (checkFile) {
        MyDialog().showProgressDialog(context);
        String apiSaveData = '${MyConstant.domain}/asm_api/saveTask.php';

        int loop = 0;
        for (var item in files) {
          int i = Random().nextInt(1000000);
          String nameFile = 'task$i.jpg';
          paths.add('/task/$nameFile');

          Map<String, dynamic> map = {};
          map['file'] =
              await MultipartFile.fromFile(item!.path, filename: nameFile);

          FormData data = FormData.fromMap(map);
          print('#### ----> saveTask === $apiSaveData');

          await Dio().post(apiSaveData, data: data).then(
            (value) async {
              print('Upload Success');
              loop++;

              if (loop >= files.length) {
                DateTime dateTime = DateTime.now();
                // String submitDateTime =
                //     DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

                SharedPreferences preferences =
                    await SharedPreferences.getInstance();

                String staffId = preferences.getString('id')!;
                String patientId = preferences.getString('patientId')!;

                String pressure = pressureController.text;
                String bloodsugar = bloodsugarController.text;
                String details = detailsController.text;
                String note = noteController.text;
                String imagePath = paths.toString();

                print('staffID ==>> $staffId,patientId ==>>$patientId');
                print(
                    '### imagePath ==>> $imagePath, dateTime ==> ${dateTime.toString()}');
                String apiSaveDataHealth =
                    '${MyConstant.domain}/asmApp_Api/addDataHealth.php?isAdd=true&staffId=$staffId&patientId=$patientId&pressure=$pressure&bloodsugar=$bloodsugar&details=$details&note=$note&imagePath=${imagePath.toString()}&dateTime=$dateTime';
                await Dio()
                    .get(apiSaveDataHealth)
                    .then((value) => Navigator.pop(context));

                Navigator.pop(context);
              }
            },
          );
        }
      }
    }
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    // print('Click From index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.iamgeicon),
          title: ShowTitle(
              title: 'กรุณาอัปโหลดรูปภาพ', textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: 'เลือกถ่ายภาพจากกล้องหรือคลังรูปภาพ',
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 130,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    processImagePicker(ImageSource.camera, index);
                  },
                  child: Text(
                    'กล้อง',
                    style: MyConstant().textWidget2(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 130,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    processImagePicker(ImageSource.gallery, index);
                  },
                  child: Text('คลังรูปภาพ', style: MyConstant().textWidget2()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: constraints.maxWidth * 0.5,
          height: constraints.maxWidth * 0.5,
          child: InkWell(
            onTap: () => chooseSourceImageDialog(0),
            child: file == null
                ? Image.asset(MyConstant.iamgeicon)
                : Image.file(file!),
          ),
        ),
      ],
    );
  }

  Row buildNote(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            maxLines: 3,
            controller: noteController,
            style: MyConstant().textWidget3(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'หมายเหตุ :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(Icons.request_quote_outlined),
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

  Row buildDetails(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            maxLines: 4,
            controller: detailsController,
            style: MyConstant().textWidget3(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'อาการอื่น ๆ เพิ่มเติม :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(Icons.request_quote_outlined),
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

  Row buildBloodSugar(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: bloodsugarController,
            style: MyConstant().textWidget3(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'ค่าน้ำตาล :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(Icons.request_quote_outlined),
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

  Row buildPressure(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: pressureController,
            style: MyConstant().textWidget3(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกข้อมูลลงในช่องว่าง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'ความดัน :',
              labelStyle: MyConstant().textWidget4(),
              prefixIcon: Icon(Icons.request_quote_outlined),
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
}
