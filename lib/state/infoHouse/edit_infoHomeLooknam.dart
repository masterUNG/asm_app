import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class EditInfoHomeLooknam extends StatefulWidget {
  final HomeModel home;
  const EditInfoHomeLooknam({Key? key, required this.home}) : super(key: key);

  @override
  _EditInfoHomeLooknamState createState() => _EditInfoHomeLooknamState();
}

class _EditInfoHomeLooknamState extends State<EditInfoHomeLooknam> {
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
  final formKey = GlobalKey<FormState>();
  TextEditingController hostNameTitleController = TextEditingController();
  TextEditingController hostFnameController = TextEditingController();
  TextEditingController hostLnameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'แก้ไขข้อมูลพื้นที่สำรวจลูกน้ำยุงลาย',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
    );
  }
}
