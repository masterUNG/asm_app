import 'dart:ui';

import 'package:flutter/material.dart';

class MyConstant {
  //General
  static String appName = 'aorsormor online';
  static String domain = 'http://aorsormor.online';

  static String domainImg = 'http://aorsormor.online/aorsormor';

  //Route
  static String routeAuthen = '/authen';
  static String routeRegister = '/register';
  static String routeServiceApp = '/serviceApp';
  static String routeService = '/service';
  static String routeAddDataPatient = '/AddDataPatient';
  static String routeHomeScreen = '/homeScreen';
  static String routeInfoHouse = '/infoHouse';
  static String routeInfoAsm = '/infoAsm';
  static String routeShowdataPatient = '/showDataPatient';
  static String routeAddDataHealth = '/AddDataHealth';
  static String routeShowDataLookNam = '/showDataLookNam';
  static String routeAddPatient = '/AddPatient';
  static String roteShowDetail = '/ShowDetailAddDataPatient';

  //Colors
  static Color primary = Color(0xff0277bd);
  static Color dark = Color(0xff58a5f0);
  static Color light = Color(0xff004c8c);
  static Color grey = Color(0xffeeeeee);

  //Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String logo = 'images/Logo.png';
  static String asm = 'images/asm.png';
  static String aosormor = 'images/aorsormor.png';
  static String iamgeicon = 'images/image_icon.png';
  static String chart = 'images/chart.png';
  static String houseicon = 'images/house_icon.png';
  static String jaricon = 'images/jar.png';
  static String drinkicon = 'images/drink.png';
  static String treeicon = 'images/tree.png';
  static String vaseicon = 'images/vase.png';
  static String cartireicon = 'images/cartire.png';
  static String washicon = 'images/wash.png';
  static String othericon = 'images/ellipsis.png';
  //Style

  TextStyle headStyle() => TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontFamily: 'Kanit',
      );
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Kanit',
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'Kanit',
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: 'Kanit',
      );

  TextStyle userNameStyle() => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Kanit',
      );

  TextStyle textWidget() => TextStyle(
        fontSize: 18,
        fontFamily: 'Kanit',
        color: Colors.black,
      );

  TextStyle textWidget2() => TextStyle(
        fontSize: 18,
        fontFamily: 'Kanit',
        color: Colors.white,
      );

  TextStyle textWidget3() => TextStyle(
        fontSize: 16,
        fontFamily: 'Kanit',
        color: Colors.black,
      );

  TextStyle textWidget4() => TextStyle(
        fontSize: 16,
        fontFamily: 'Kanit',
        color: Colors.grey,
      );

  TextStyle textWidget5() => TextStyle(
        fontSize: 12,
        fontFamily: 'Kanit',
        color: Colors.black,
      );

  TextStyle textWidget6() => TextStyle(
        fontSize: 18,
        fontFamily: 'Kanit',
        color: Colors.black,
      );

  Widget appNameHead(String string) => Container(
        margin: EdgeInsets.only(top: 100),
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: dark,
            fontFamily: 'Kanit',
          ),
        ),
      );
}
