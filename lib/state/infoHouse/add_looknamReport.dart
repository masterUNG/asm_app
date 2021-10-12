import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/reportlooknam_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/utility/my_dialog.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLooknamReport extends StatefulWidget {
  const AddLooknamReport({Key? key}) : super(key: key);

  @override
  _AddLooknamReportState createState() => _AddLooknamReportState();
}

class _AddLooknamReportState extends State<AddLooknamReport> {
  final formkey = GlobalKey<FormState>();
  HomeModel? home;
  ReportLooknam? reportLooknam;
  String? reportId;
  String? watertotal;
  String? waterfound;
  String? drinktotal;
  String? drinkfound;
  String? containerholdertotal;
  String? containerholderfound;
  String? placemattotal;
  String? placematfound;
  String? vasetotal;
  String? vasefound;
  String? tiretotal;
  String? tirefound;
  String? othercontainertotal;
  String? othercontainerfound;
  String? total;
  String? amount;
  String? sum;
  String? sums;
  String? dateTime;

  TextEditingController watertotalController = TextEditingController();
  TextEditingController waterfoundController = TextEditingController();
  TextEditingController drinktotalController = TextEditingController();
  TextEditingController drinkfoundController = TextEditingController();
  TextEditingController containerholdertotalController =
      TextEditingController();
  TextEditingController containerholderfoundController =
      TextEditingController();
  TextEditingController placemattotalController = TextEditingController();
  TextEditingController placematfoundController = TextEditingController();
  TextEditingController vasetotalController = TextEditingController();
  TextEditingController vasefoundController = TextEditingController();
  TextEditingController tiretotalController = TextEditingController();
  TextEditingController tirefoundController = TextEditingController();
  TextEditingController othercontainertotalController = TextEditingController();
  TextEditingController othercontainerfoundController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'รายงานลูกน้ำยุงลาย',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Form(
              key: formkey,
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ShowTitle(
                            title: 'รายละเอียดผลการสำรวจลูกน้ำยุงลาย',
                            textStyle: MyConstant().textWidget3(),
                          ),
                          buildCard1(),
                          buildCard2(),
                          buildCard3(),
                          buildCard4(),
                          buildCard5(),
                          buildCard6(),
                          buildCard7(),
                          buildShowText(constraints)
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
    );
  }

  Widget buildShowText(BoxConstraints constraints) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                Navigator.pop(context);
                processUploadReport();
              }
            },
            child: Text(
              'ส่งรายงานผลการสำรวจ',
              style: MyConstant().textWidget2(),
            ),
          ),
        ),
      );

  ExpansionTile buildCard7() {
    return ExpansionTile(
      leading: Image.asset(
        'images/ellipsis.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'ภาชนะอื่น ๆ ',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      style: MyConstant().textWidget3(),
                      controller: othercontainertotalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: othercontainerfoundController,
                      style: MyConstant().textWidget3(),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile buildCard6() {
    return ExpansionTile(
      leading: Image.asset(
        'images/cartire.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'ยางรถยนต์',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: tiretotalController,
                      style: MyConstant().textWidget3(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: tirefoundController,
                      style: MyConstant().textWidget3(),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile buildCard5() {
    return ExpansionTile(
      leading: Image.asset(
        'images/vase.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'แจกัน',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: vasetotalController,
                      style: MyConstant().textWidget3(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: vasefoundController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: MyConstant().textWidget3(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile buildCard4() {
    return ExpansionTile(
      leading: Image.asset(
        'images/tree.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'จานรองกระถาง',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: placemattotalController,
                      style: MyConstant().textWidget3(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: placematfoundController,
                      textAlign: TextAlign.center,
                      style: MyConstant().textWidget3(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile buildCard3() {
    return ExpansionTile(
      leading: Image.asset(
        'images/wash.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'ที่รอง',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: containerholdertotalController,
                      keyboardType: TextInputType.number,
                      style: MyConstant().textWidget3(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: containerholderfoundController,
                      textAlign: TextAlign.center,
                      style: MyConstant().textWidget3(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile buildCard2() {
    return ExpansionTile(
      leading: Image.asset(
        'images/drink.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'น้ำดื่ม',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      style: MyConstant().textWidget3(),
                      controller: drinktotalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      style: MyConstant().textWidget3(),
                      controller: drinkfoundController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile buildCard1() {
    return ExpansionTile(
      leading: Image.asset(
        'images/jar.png',
        width: 25,
        height: 25,
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          'น้ำใช้',
          style: MyConstant().textWidget3(),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('จำนวนภาชนะทั้งหมด', style: MyConstant().textWidget3()),
              Text('จำนวนที่พบลูกน้ำยุงลาย', style: MyConstant().textWidget3())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: watertotalController,
                      style: MyConstant().textWidget3(),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: MediaQuery.of(context).size.width * 0.30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูลลงในช่องว่าง';
                        } else {
                          return null;
                        }
                      },
                      controller: waterfoundController,
                      style: MyConstant().textWidget3(),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.dark),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyConstant.light),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> processUploadReport() async {
    if (formkey.currentState!.validate()) {
      MyDialog().showProgressDialog(context);
      DateTime dateTime = DateTime.now();
      // String submitDateTime = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String staffId = preferences.getString('userId')!;
      // String staffName = preferences.getString('name')!;
      String homeId = preferences.getString('homeId')!;

      String watertotal = watertotalController.text;
      String waterfound = waterfoundController.text;
      String drinktotal = drinktotalController.text;
      String drinkfound = drinkfoundController.text;
      String containerholdertotal = containerholdertotalController.text;
      String containerholderfound = containerholderfoundController.text;
      String placemattotal = placemattotalController.text;
      String placematfound = placematfoundController.text;
      String vasetotal = vasetotalController.text;
      String vasefound = vasefoundController.text;
      String tiretotal = tiretotalController.text;
      String tirefound = tirefoundController.text;
      String othercontainertotal = othercontainertotalController.text;
      String othercontainerfound = othercontainerfoundController.text;

      var total = int.parse(watertotal.trim()) +
          int.parse(drinktotal.trim()) +
          int.parse(containerholdertotal.trim()) +
          int.parse(placemattotal.trim()) +
          int.parse(vasetotal.trim()) +
          int.parse(tiretotal.trim()) +
          int.parse(othercontainertotal.trim());

      print(total);

      var amount = int.parse(waterfound.trim()) +
          int.parse(drinkfound.trim()) +
          int.parse(containerholderfound.trim()) +
          int.parse(placematfound.trim()) +
          int.parse(vasefound.trim()) +
          int.parse(tirefound.trim()) +
          int.parse(othercontainerfound.trim());

      print(amount);

      var sum = (amount / total) * 100;
      String sums = sum.toStringAsFixed(2).trim();
      print(sums);

      String apiInsertData =
          '${MyConstant.domain}/asmApp_Api/addReportLooknam.php?isAdd=true&staffId=$staffId&homeId=$homeId&watertotal=$watertotal&waterfound=$waterfound&drinktotal=$drinktotal&drinkfound=$drinkfound&containerholdertotal=$containerholdertotal&containerholderfound=$containerholderfound&placemattotal=$placemattotal&placematfound=$placematfound&vasetotal=$vasetotal&vasefound=$vasefound&tiretotal=$tiretotal&tirefound=$tirefound&othercontainertotal=$othercontainertotal&othercontainerfound=$othercontainerfound&total=$total&amount=$amount&sum=$sums&dateTime=$dateTime';
      await Dio().get(apiInsertData).then((value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'สรุปผลการสำรวจลูกน้ำยุงลาย',
                    style: MyConstant().h2Style(),
                  ),
                ],
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'CI $sums%',
                      style: MyConstant().h1Style(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '(ดัชนีความชุกลูกน้ำยุงลายที่พบในบ้าน)',
                      style: MyConstant().h3Style(),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.green[800])),
                    Expanded(child: Divider(color: Colors.green[800])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'สำรวจทั้งหมด $total ภาชนะ',
                      style: MyConstant().h2Style(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'จุดที่พบลูกน้ำ $amount ภาชนะ',
                      style: MyConstant().h2Style(),
                    )
                  ],
                ),
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
                          style: MyConstant().h2Style(),
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
                        onPressed: () {
                          Navigator.pop(context);
                          // processUploadReport();
                        },
                        child: Text(
                          'ยืนยัน',
                          style: MyConstant().h2Style(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      });
    }
  }
}
