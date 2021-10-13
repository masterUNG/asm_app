import 'package:asm_app/state/service_app.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/utility/my_dialog.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddreportMonth extends StatefulWidget {
  const AddreportMonth({Key? key}) : super(key: key);

  @override
  _AddreportMonthState createState() => _AddreportMonthState();
}

class _AddreportMonthState extends State<AddreportMonth> {
  int currentStep = 0;
  bool isCompleted = false;
  final formkey = GlobalKey<FormState>();
  DateTime now = DateTime.now();

  String? staffId;
  String? HealthPromotion1_1;
  String? HealthPromotion1_1_1;
  String? HealthPromotion1_2;
  String? HealthPromotion1_2_1;
  String? HealthPromotion1_3;
  String? HealthPromotion1_3_1;
  String? HealthPromotion1_4;
  String? Surveillance2_1;
  String? Surveillance2_2;
  String? Surveillance2_3;
  String? Surveillance2_4;
  String? Surveillance2_5;
  String? HealthRestoration3_1;
  String? ConsumerProtection4_1;
  String? CommunityHealth5_1;
  String? CommunityHealth5_2;
  String? OtherActivities6_1;
  String? OtherActivities6_2;
  String? statusReportMonth;
  String? dateTime;

  TextEditingController healtPromotion1Controller = TextEditingController();
  TextEditingController healtPromotion1_1Controller = TextEditingController();
  TextEditingController healtPromotion1_2Controller = TextEditingController();
  TextEditingController healtPromotion1_2_1Controller = TextEditingController();
  TextEditingController healtPromotion1_3Controller = TextEditingController();
  TextEditingController healtPromotion1_3_1Controller = TextEditingController();
  TextEditingController healtPromotion1_4Controller = TextEditingController();
  TextEditingController surveillance2_1Controller = TextEditingController();
  TextEditingController surveillance2_2Controller = TextEditingController();
  TextEditingController surveillance2_3Controller = TextEditingController();
  TextEditingController surveillance2_4Controller = TextEditingController();
  TextEditingController surveillance2_5Controller = TextEditingController();
  TextEditingController healthRestoration3_1Controller =
      TextEditingController();
  TextEditingController consumerProtection4_1Controller =
      TextEditingController();
  TextEditingController communityHealth5_1Controller = TextEditingController();
  TextEditingController communityHealth5_2Controller = TextEditingController();
  TextEditingController otherActivities6_1Controller = TextEditingController();
  TextEditingController otherActivities6_2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายงานอสม. ประจำเดือน',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
        backgroundColor: MyConstant.primary,
      ),
      body: isCompleted
          ? buildComplete()
          : Stepper(
              physics: AlwaysScrollableScrollPhysics(),
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  upLoadReportToData();
                  setState(() => isCompleted = true);
                  print('completeeee');
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
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                          ),
                          onPressed: onStepContinue,
                          child: Text(
                            isLastStep ? 'ส่งรายงาน' : 'ต่อไป',
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
                              'กลับ',
                              style: MyConstant().textWidget2(),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
    );
  }

  List<Step> getSteps() => [
        // Steep 1
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            '',
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
                      Container(
                        decoration: BoxDecoration(
                          color: MyConstant.dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'การส่งเสริมสุขภาพ',
                                style: MyConstant().textWidget2(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardStep1(),
                      CardStep1_1(),
                      CardStep1_2(),
                      CardStep1_3(),
                      CardStep1_4(),
                      CardStep1_5(),
                      CardStep1_6(),
                    ],
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
            '',
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
                      Container(
                        decoration: BoxDecoration(
                          color: MyConstant.dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'การเฝ้าระวัง ป้องกัน และควบคุมโรค',
                                style: MyConstant().textWidget2(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardStep2(),
                      CardStep2_1(),
                      CardStep2_2(),
                      CardStep2_3(),
                      CardStep2_4(),
                    ],
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
            '',
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
                      Container(
                        decoration: BoxDecoration(
                          color: MyConstant.dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'การฟื้นฟูสุขภาพ',
                                style: MyConstant().textWidget2(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardStep3(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text(
            '',
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
                      Container(
                        decoration: BoxDecoration(
                          color: MyConstant.dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'การคุ้มครองผู้บริโภค',
                                style: MyConstant().textWidget2(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardStep4(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 4,
          title: Text(
            '',
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
                      Container(
                        decoration: BoxDecoration(
                          color: MyConstant.dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'การจัดการสุขภาพชุมชน',
                                style: MyConstant().textWidget2(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardStep5(),
                      CardStep5_1(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 5 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 5,
          title: Text(
            '',
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
                      Container(
                        decoration: BoxDecoration(
                          color: MyConstant.dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'กิจกรรมอื่น ๆ',
                                style: MyConstant().textWidget2(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardStep6(),
                      CardStep6_1(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ];

  Card CardStep6_1() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 6.2 ผู้ที่เลิกบุหรี่ได้ไม่น้อยกว่า 6 เดือน (รายใหม่)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: otherActivities6_2Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep6() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 6.1 อสม. ชักชวนคนให้เลิกบุหรี่ (ผลงานสะสม)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: otherActivities6_1Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep5_1() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 5.2 จัดทำแผนสุขภาพ จัดหางบประมาณ จัดกิจกรรมสุขภาพ และประเมินผล',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: communityHealth5_2Controller,
              decoration: InputDecoration(
                labelText: 'ครั้ง',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep5() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 5.1 อสม. ร่วมกิจกรรมจิตอาสากับเครือข่ายอื่น',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: communityHealth5_1Controller,
              decoration: InputDecoration(
                labelText: 'ครั้ง',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep4() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 4.1 เฝ้าระวังและให้คำแนะนำการบริโภคอาหารปลอดภัย',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: consumerProtection4_1Controller,
              decoration: InputDecoration(
                labelText: 'ครั้ง',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep3() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 3.1 เยี่ยมบ้าน ให้คำแนะนำการดูแลผู้ป่วยโรคเบาหวาน ความดันโลหิต มะเร็ง หัวใจ ฯลฯ',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healthRestoration3_1Controller,
              decoration: InputDecoration(
                labelText: 'ครั้ง',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.home,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep2_4() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 2.5 ให้คำแนะนำประชาชนลดกิน หวาน อาหารมันและเค็ม',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: surveillance2_5Controller,
              decoration: InputDecoration(
                labelText: 'ครัวเรือน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep2_3() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 2.4 ให้คำแนะนำประชาชนบริโภคผลิตภัณฑ์/อาหาร/เกลือที่ผสมไอโอดีน',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: surveillance2_4Controller,
              decoration: InputDecoration(
                labelText: 'ครัวเรือน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep2_2() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 2.3 เฝ้าระวัง คัดกรอง และให้คำแนะนำกลุ่มเสี่ยงโรค (โรคเบาหวาน โรคความดันโลหิตสูง โรคมะเร็ง โรคหัวใจ โรคหลอกเลือดสมอง)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: surveillance2_3Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep2_1() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 2.2 เฝ้าระวัง ป้องกัน ควบคุมโรคไข้เลือดออก (ปิด ล้าง เลี่ยง หยุด)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: surveillance2_2Controller,
              decoration: InputDecoration(
                labelText: 'ครัวเรือน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep2() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 2.1 เฝ้าระวัง ป้องกัน ควบคุมโรคไข้เลือดออก (ปิด เปลี่ยน ปล่อย ปรับปรุง ปฏิบัติเป็นนิสัย)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: surveillance2_1Controller,
              decoration: InputDecoration(
                labelText: 'ครัวเรือน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1_6() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.4 อสม. เยี่ยมบ้านและให้คำแนะนำผู้พิการด้านการดูแลสุขภาพ',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1_4Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1_5() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.3.1 ผู้สูงอายุที่เป็นโรคเรื้อรังและถูกทอดทิ้งเพียงลำพัง (รายใหม่)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1_3_1Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1_4() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.3 อสม. เยี่ยมบ้านและให้คำแนะนำผู้สูงอายุด้านการดูแลสุขภาพ',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1_3Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1_3() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.2.1 มารดาที่ไม่สามารถเลี้ยงดูบุตรด้วยนมแม่อย่างเดียวครบ 6 เดือน (รายใหม่)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1_2_1Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1_2() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.2 อสม. บริการเยี่ยมให้คำแนะนำหญิงหลังคลอด (รายใหม่)',
                style: MyConstant().textWidget3(),
                // maxLines: 2,
                // overflow: TextOverflow.clip,
                // softWrap: true,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1_2Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1_1() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.1.1 อสม. ค้นหาหญิงตั้งครรภ์อายุต่ำกว่า 15 ปี (รายใหม่)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1_1Controller,
              decoration: InputDecoration(
                labelText: 'คน',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card CardStep1() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ข้อ 1.1 อสม. เยี่ยมให้คำแนะนำหญิงตั้งครรภ์ (รายใหม่)',
                style: MyConstant().textWidget3(),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                } else {
                  return null;
                }
              },
              controller: healtPromotion1Controller,
              decoration: InputDecoration(
                labelText: 'คน/ครั้ง',
                labelStyle: MyConstant().textWidget4(),
                prefixIcon: Icon(
                  Icons.face_outlined,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildComplete() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 32),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width * 0.50,
              child: ShowImage(path: MyConstant.successicon),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'ส่งรายงานประจำเดือน',
                    style: MyConstant().h1Style(),
                  ),
                  Text(
                    'สำเร็จแล้ว',
                    style: MyConstant().h1Style(),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceApp()));
                },
                child: Text(
                  'กลับสู่หน้าหลัก.',
                  style: MyConstant().textWidget2(),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<Null> upLoadReportToData() async {
    if (formkey.currentState!.validate()) {
      MyDialog().showProgressDialog(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String staffId = preferences.getString('userId')!;

      String HealthPromotion1_1 = healtPromotion1Controller.text;
      String HealthPromotion1_1_1 = healtPromotion1_1Controller.text;
      String HealthPromotion1_2 = healtPromotion1_2Controller.text;
      String HealthPromotion1_2_1 = healtPromotion1_2_1Controller.text;
      String HealthPromotion1_3 = healtPromotion1_3Controller.text;
      String HealthPromotion1_3_1 = healtPromotion1_3_1Controller.text;
      String HealthPromotion1_4 = healtPromotion1_4Controller.text;
      String Surveillance2_1 = surveillance2_1Controller.text;
      String Surveillance2_2 = surveillance2_2Controller.text;
      String Surveillance2_3 = surveillance2_3Controller.text;
      String Surveillance2_4 = surveillance2_4Controller.text;
      String Surveillance2_5 = surveillance2_5Controller.text;
      String HealthRestoration3_1 = healthRestoration3_1Controller.text;
      String ConsumerProtection4_1 = consumerProtection4_1Controller.text;
      String CommunityHealth5_1 = communityHealth5_1Controller.text;
      String CommunityHealth5_2 = communityHealth5_2Controller.text;
      String OtherActivities6_1 = otherActivities6_1Controller.text;
      String OtherActivities6_2 = otherActivities6_2Controller.text;

      String apiInsertData =
          '${MyConstant.domain}/asmApp_Api/addReportMonth.php?isAdd=true&staffId=$staffId&HealthPromotion1_1=$HealthPromotion1_1&HealthPromotion1_1_1=$HealthPromotion1_1_1&HealthPromotion1_2=$HealthPromotion1_2&HealthPromotion1_2_1=$HealthPromotion1_2_1&HealthPromotion1_3=$HealthPromotion1_3&HealthPromotion1_3_1=$HealthPromotion1_3_1&HealthPromotion1_4=$HealthPromotion1_4&Surveillance2_1=$Surveillance2_1&Surveillance2_2=$Surveillance2_2&Surveillance2_3=$Surveillance2_3&Surveillance2_4=$Surveillance2_4&Surveillance2_5=$Surveillance2_5&HealthRestoration3_1=$HealthRestoration3_1&ConsumerProtection4_1=$ConsumerProtection4_1&CommunityHealth5_1=$CommunityHealth5_1&CommunityHealth5_2=$CommunityHealth5_2&OtherActivities6_1=$OtherActivities6_1&OtherActivities6_2=$OtherActivities6_2&statusReportMonth=$statusReportMonth&dateTime=$dateTime';
      await Dio().get(apiInsertData).then((value) => Navigator.pop(context));
      print('staffId ===> $staffId');
      print(apiInsertData);
    }
  }
}
