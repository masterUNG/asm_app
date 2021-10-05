import 'package:asm_app/models/home_model.dart';
import 'package:asm_app/models/reportlooknam_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

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
      appBar:AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'รายงานลูกน้ำยุงลาย',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
    );
  }
}
