import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class AddreportMonth extends StatefulWidget {
  const AddreportMonth({Key? key}) : super(key: key);

  @override
  _AddreportMonthState createState() => _AddreportMonthState();
}

class _AddreportMonthState extends State<AddreportMonth> {
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
      body: Text('data'),
    );
  }
}
