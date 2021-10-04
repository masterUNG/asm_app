import 'package:asm_app/state/home/reportASM/add_reportHealth.dart';
import 'package:asm_app/state/home/reportASM/add_reportMonth.dart';
import 'package:asm_app/state/home/reportASM/showData_HomeLooknam.dart';
import 'package:asm_app/state/home/reportASM/showData_Patient.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ReportASM extends StatefulWidget {
  const ReportASM({Key? key}) : super(key: key);

  @override
  _ReportASMState createState() => _ReportASMState();
}

class _ReportASMState extends State<ReportASM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text(
          'รายงาน อสม.',
          style: MyConstant().textWidget2(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                builReportDataHealth(context),
                buildLookNam(context),
                buildReportMonth(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReportMonth(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.25,
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
                'รายงานอสม. ประจำเดือน',
                style: TextStyle(fontFamily: 'Kanit', fontSize: 22),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddreportMonth()
                    // ShowDataHomeLooknam(),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildLookNam(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.25,
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
                    builder: (context) => ShowDataHomeLooknamReport()
                    // ShowDataHomeLooknam(),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget builReportDataHealth(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.25,
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
                  builder: (context) => ShowDataPatientAndAddReport(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
