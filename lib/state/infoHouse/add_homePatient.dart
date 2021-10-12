import 'dart:async';
import 'dart:convert';

import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchAndAddHomePatient extends StatefulWidget {
  const SearchAndAddHomePatient({Key? key, index}) : super(key: key);

  @override
  _SearchAndAddHomePatientState createState() =>
      _SearchAndAddHomePatientState();
}

class _SearchAndAddHomePatientState extends State<SearchAndAddHomePatient> {
  List<HomeModel> homeModels = [];
  List<HomeModel> searchHome = [];
  List<HomeModel> selectedHome = [];

  final debouncers = Debouncer(millisecond: 500);

  bool loadStatus = true; // Process Load JSON
  bool status = true;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    showDataAllHomeLooknam();
  }

  Future<Null> showDataAllHomeLooknam() async {
    if (homeModels.length != 0) {
      homeModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    preferences.setString('homeId', '');
    String homeId = data![0];

    String apiShowAllHome =
        '${MyConstant.domain}/asmApp_Api/getAllHome.php?isAdd=true&homeId=$homeId';
    await Dio().get(apiShowAllHome).then((value) async {
      for (var item in json.decode(value.data)) {
        HomeModel model = HomeModel.fromMap(item);
        List<String> data = [];
        data.add(model.homeId);
        setState(() {
          homeModels.add(model);
          searchHome = homeModels;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลชุมชน',
          style: MyConstant().textWidget2(),
        ),
        backgroundColor: MyConstant.primary,
        centerTitle: true,
      ),
      body: homeModels.length == 0
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
            itemCount: searchHome.length,
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
                        children: <Widget>[
                          Text(
                            searchHome[index].hostNameTitle,
                            style: MyConstant().textWidget3(),
                          ),
                          Text(
                            searchHome[index].hostFname,
                            style: MyConstant().textWidget3(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              searchHome[index].hostLname,
                              style: MyConstant().textWidget3(),
                            ),
                          )
                        ],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                            'บ้านเลขที่ ${searchHome[index].houseNo} หมู่ที่ ${searchHome[index].villageNo}',
                            style: MyConstant().textWidget4(),
                          ),
                        ],
                      ),
                      onTap: () {
                        Map<String, dynamic> map = {};
                        map['index'] = index;
                        map['homeId'] = homeModels[index].homeId;
                        map['houseNo'] = homeModels[index].houseNo;
                        map['villageNo'] = homeModels[index].villageNo;
                        map['village'] = homeModels[index].village;
                        map['subDistrictId'] = homeModels[index].subDistrictId;
                        map['districtId'] = homeModels[index].districtId;
                        map['provinceId'] = homeModels[index].provinceId;
                        print('### map ที่ส่งกลับไป ===> $map');
                        Navigator.pop(context, map);
                      }),
                ))),
      );

  Widget buildSearch(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        onChanged: (value) {
          debouncers.run(() {
            setState(() {
              searchHome = homeModels
                  .where((element) => element.houseNo
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
