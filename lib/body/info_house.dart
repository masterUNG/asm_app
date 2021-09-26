import 'package:asm_app/state/infoHouse/show_dataHomeInfoHouse.dart';
import 'package:asm_app/state/infoHouse/show_dataPatientInfoHouse.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:flutter/material.dart';

class InfoHouse extends StatefulWidget {
  const InfoHouse({Key? key}) : super(key: key);

  @override
  _InfoHouseState createState() => _InfoHouseState();
}

class _InfoHouseState extends State<InfoHouse> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildInfoDataPatinet(context),
          buildInfoDataHomeLooknam(context)
        ],
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
                'ข้อมูลผู้ป่วยภายในชุมชน',
                style: TextStyle(fontFamily: 'Kanit', fontSize: 22),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDataPatinetFromInfoHouse(),
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
                'ข้อมูลพื้นที่สำรวจลูกน้ำยุงลาย',
                style: TextStyle(fontFamily: 'Kanit', fontSize: 22),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDataHomeFromInfoHouse(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
