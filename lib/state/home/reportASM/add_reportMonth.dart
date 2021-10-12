import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class AddreportMonth extends StatefulWidget {
  const AddreportMonth({Key? key}) : super(key: key);

  @override
  _AddreportMonthState createState() => _AddreportMonthState();
}

class _AddreportMonthState extends State<AddreportMonth> {
  int currentStep = 0;
  bool isCompleted = false;
  final formkey = GlobalKey<FormState>();
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
                            isLastStep ? 'ตกลง' : 'ต่อไป',
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
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            'การส่งเสริมสุขภาพ',
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
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน/ครั้ง',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
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
            'การเฝ้าระวัง ป้องกันและควบคุม',
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
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
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
            'การเฝ้าระวัง ป้องกันและควบคุม',
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
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'คน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                      Card(
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
                                decoration: InputDecoration(
                                  labelText: 'ครัวเรือน',
                                  labelStyle: MyConstant().textWidget4(),
                                  prefixIcon: Icon(
                                    Icons.face_outlined,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.dark),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyConstant.light),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ];

  buildComplete() {}
}
