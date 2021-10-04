import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowInfoHomeLooknam extends StatefulWidget {
  final HomeModel homelooknam;
  const ShowInfoHomeLooknam({Key? key, required this.homelooknam})
      : super(key: key);

  @override
  _ShowInfoHomeLooknamState createState() => _ShowInfoHomeLooknamState();
}

class _ShowInfoHomeLooknamState extends State<ShowInfoHomeLooknam> {
  HomeModel? homelooknam;
  List<HomeModel> homelooknams = [];
  HomeModel? home;
  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data

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
    );
  }
}
