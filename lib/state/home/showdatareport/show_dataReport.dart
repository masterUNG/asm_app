import 'package:asm_app/state/home/showdatareport/show_dataAndreport.dart';
import 'package:asm_app/state/home/showdatareport/show_dataHomeAndReport.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowDataReport extends StatefulWidget {
  const ShowDataReport({Key? key}) : super(key: key);

  @override
  _ShowDataReportState createState() => _ShowDataReportState();
}

class _ShowDataReportState extends State<ShowDataReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'ดูรายงาน อสม.',
          style: MyConstant().textWidget2(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildInfoDataPatinet(context),
            buildInfoDataHomeLooknam(context)
          ],
        ),
      ),
    );
  }

  Container buildInfoDataPatinet(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 1.20,
        child: Card(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: MyConstant.dark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'รายงานบันทึกการตรวจสุขภาพ',
                style: TextStyle(fontFamily: 'Kanit', fontSize: 22),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDataPatientReport(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Container buildInfoDataHomeLooknam(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 1.20,
        child: Card(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: MyConstant.dark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'รายงานการสำรวจลูกน้ำยุงลาย',
                style: TextStyle(fontFamily: 'Kanit', fontSize: 22),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDataReportLooknam(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
