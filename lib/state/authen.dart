import 'dart:convert';

import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/utility/my_dialog.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double? screen;
  bool redEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernamesController = TextEditingController();
  TextEditingController passwordsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildImage(constraints),
                    buildAppName(),
                    buildUser(constraints),
                    buildPassword(constraints),
                    builLogin(constraints),
                    buildOtherLine(),
                    buildShowText(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildShowText(BoxConstraints constraints) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: constraints.maxWidth * 0.95,
        child: Center(
          child: Text(
            'แอปพลิเคชันนี้ให้บริการเฉพาะกลุ่ม อสม. เท่านั้น',
            style: MyConstant().textWidget(),
          ),
        ));
  }

  Widget buildOtherLine() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              "วิธีการใช้งานแอปพลิเคชัน",
              style: TextStyle(
                  color: Colors.black87, fontFamily: 'Kanit', fontSize: 16),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.green[800]),
          ),
        ],
      ),
    );
  }

  Container builLogin(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyConstant.primary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            checkAuthen();
          }
        },
        child: Text(
          'เข้าสู่ระบบ',
          style: MyConstant().textWidget2(),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String usernames = usernamesController.text;
    String passwords = passwordsController.text;

    String apiCheckAuthen =
        '${MyConstant.domain}/asmApp_Api/getUserWhereUser.php?isAdd=true&usernames=$usernames';

    await Dio().get(apiCheckAuthen).then((value) async {
      print('value ==>> $value');
      if (value.toString() == 'null') {
        MyDialog().normalDialog(
            context, 'Username ไม่ถูกต้อง', 'ไม่มี $usernames ในระบบ');
      } else {
        var result = json.decode(value.data);
        print('result ==> $result');

        for (var item in result) {
          UserModel model = UserModel.fromMap(item);
          if (passwords == model.passwords) {
            List<String> data = [];
            data.add(model.userId);
            data.add(model.firstname);
            data.add(model.usernames);
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setStringList('data', data);
            preferences.setString('userId', model.userId);
            preferences.setString('fname', model.firstname);
            preferences.setString('usernames', model.usernames);

            Navigator.pushNamedAndRemoveUntil(
                context, MyConstant.routeServiceApp, (route) => false);
          } else {
            MyDialog().normalDialog(
                context, 'รหัสผ่านไม่ถูกต้อง', 'กรุณาลองใหม่อีกครั้ง');
          }
        }
      }
    });
  }

  Container buildPassword(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        controller: passwordsController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกรหัสผ่านภายในช่องว่าง';
          } else {
            return null;
          }
        },
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
            icon: Icon(Icons.remove_red_eye),
          ),
          labelText: 'Password :',
          labelStyle: MyConstant().textWidget4(),
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildUser(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        controller: usernamesController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก username ในช่องว่าง';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyConstant().textWidget4(),
          labelText: 'Username :',
          prefixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  ShowTitle buildAppName() => ShowTitle(
        title: MyConstant.appName,
        textStyle: MyConstant().h1Style(),
      );

  Container buildImage(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 75),
      width: constraints.maxWidth * 0.65,
      child: ShowImage(path: MyConstant.aosormor),
    );
  }
}
