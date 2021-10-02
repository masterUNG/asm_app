import 'dart:convert';

import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoASM extends StatefulWidget {
  const InfoASM({Key? key}) : super(key: key);

  @override
  _InfoASMState createState() => _InfoASMState();
}

class _InfoASMState extends State<InfoASM> {
  UserModel? userModel;
  String? fullname;
  String? address;
  String? nameLogin, showTitleName, showUsername, showlname, id, showAddress;

  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data

  @override
  void initState() {
    super.initState();
    // readDataUser();
    showStaff();
    // showPatientFromStaff();
  }

  Future<Null> showStaff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');

    String apiCheckUser =
        '${MyConstant.domain}/asmApp_Api/getUserWhereUser.php?isAdd=true&usernames=${data![2]}';

    await Dio().get(apiCheckUser).then((value) {
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          nameLogin = data[1];
          showTitleName = model.nameTitles;
          showUsername = model.firstname;
          showlname = model.lastname;
          showAddress = model.address;
        });
      }
    });

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String id = preferences.getString('id')!;
    // print('id login === $id');
    // String apiGetStaff =
    //     '${MyConstant.domain}/asm_api/getUserWhereId.php?isAdd=true&id=$id';
    // await Dio().get(apiGetStaff).then((value) {
    //   for (var item in json.decode(value.data)) {
    //     setState(() {
    //       userModel = UserModel.fromMap(item);
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: GestureDetector(
            child: Container(
              child: Column(
                children: <Widget>[
                  buildCardName(context),
                  buildFunction(constraints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFunction(BoxConstraints constraints) {
    return Container(
      
    );
  }

  Widget buildCardName(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
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
              Text(
                '$showTitleName',
                style: MyConstant().textWidget3(),
              ),
              // Container(
              //   child: Text(
              //     '${showUsername!}',
              //     style: MyConstant().textWidget3(),
              //   ),
              // ),
              Text(
                '$nameLogin',
                style: MyConstant().textWidget3(),
              ),
              Text(
                '$showlname',
                style: MyConstant().textWidget3(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
