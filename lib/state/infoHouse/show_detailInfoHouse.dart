import 'dart:convert';

import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/user_model.dart';
import 'package:asm_app/state/infoHouse/edit_infoHomeLooknam.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailInfoHouse extends StatefulWidget {
  final HomeModel detailhome;
  const ShowDetailInfoHouse({Key? key, required this.detailhome})
      : super(key: key);

  @override
  _ShowDetailInfoHouseState createState() => _ShowDetailInfoHouseState();
}

class _ShowDetailInfoHouseState extends State<ShowDetailInfoHouse> {
  HomeModel? home;
  UserModel? userModel;
  List<HomeModel> homes = [];
  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data

  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
    home = widget.detailhome;
  }

  Future<Null> loadValueFromAPI() async {
    if (homes.length != 0) {
      homes.clear();
      loadStatus = true;
      status = true;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String homeId = preferences.getString('homeId')!;
    String userId = preferences.getString('userId')!;
    print('staffid login === $userId');

    String apiGetValue =
        '${MyConstant.domain}/asmApp_Api/show_DetailHomeLooknamWhereId.php?isAdd=true&homeid=$homeId';
    await Dio().get(apiGetValue).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          HomeModel model = HomeModel.fromMap(item);
          setState(() {
            homes.add(model);
            userModel = UserModel.fromMap(item);
          });
          // print('pressure ===> ${model.pressure}');
        }
      } else {
        setState(() {
          status = false;
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
          'ข้อมูลพื้นที่สำรวจลูกน้ำยุงลาย',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            height: MediaQuery.of(context).size.height * 0.85,
            child: Card(
              child: Column(
                children: <Widget>[
                  buildShowImage(constraints),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'เจ้าหน้าที่อสม. ที่รับผิดชอบ: ${userModel!.nameTitles}${userModel!.firstname} ${userModel!.lastname}',
                        style: MyConstant().textWidget3(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ชื่อ-นามสกุล: ${home!.hostNameTitle}${home!.hostFname} ${home!.hostLname}',
                        style: MyConstant().textWidget3(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ที่อยู่: บ้านเลขที่ ${home!.houseNo} บ้าน${home!.village} หมู่ที่ ${home!.villageNo}',
                        style: MyConstant().textWidget3(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ต. ${home!.subDistrictId} อ.${home!.districtId} จ.${home!.provinceId}',
                        style: MyConstant().textWidget3(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'จำนวนผู้ที่อยู่อาศัย: ${home!.quantity}',
                        style: MyConstant().textWidget3(),
                      ),
                    ],
                  ),
                  buidBtnEditDelete(constraints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buidBtnEditDelete(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditInfoHomeLooknam(home: home!),
                  )).then((value) => Navigator.pop(context));
            },
            icon: Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              deleteData(home!.homeId);
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Future<Null> deleteData(String patientId) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.aosormor),
          title: ShowTitle(
            title: 'คุณต้องการลบข้อมูลใช่หรือไม่',
            textStyle: MyConstant().textWidget(),
          ),
          subtitle: ShowTitle(
            title: 'กดตกลงเพื่อลบข้อมูล',
            textStyle: MyConstant().textWidget3(),
          ),
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
                  onPressed: () async {
                    Navigator.pop(context);
                    String apiDelete =
                        '${MyConstant.domain}/asm_api/deleteHomeLooknamWhereId.php?isAdd=true&homeid=${home!.homeId}';
                    await Dio()
                        .get(apiDelete)
                        .then((value) => Navigator.pop(context));
                    print('delete ==> $apiDelete');
                  },
                  child: Text(
                    'ยืนยัน',
                    style: MyConstant().textWidget2(),
                  ),
                ),
              ),
            ],
          )
        ],
        //
      ),
    );
  }

  Widget buildShowImage(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 32),
          padding: EdgeInsets.only(top: 8),
          child: CircleAvatar(
            backgroundColor: MyConstant.grey,
            backgroundImage: AssetImage('images/house_icon.png'),
            radius: 56,
          ),
        )
      ],
    );
  }
}
