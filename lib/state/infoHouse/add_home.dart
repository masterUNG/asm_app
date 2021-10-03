import 'package:asm_app/models/home_model.dart';
import 'package:flutter/material.dart';

class AddHome extends StatefulWidget {
  const AddHome({Key? key}) : super(key: key);

  @override
  _AddHomeState createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  HomeModel? home;
  String? homeId;
  String? staffId;
  String? hostNameTitle;
  String? hostFname;
  String? hostLname;
  String? houseNo;
  String? villageNo;
  String? village;
  String? subDistrictId;
  String? districtId;
  String? provinceId;
  String? quantity;
  String? area;
  String? dateTime;
  final formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
