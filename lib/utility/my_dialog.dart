import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_image.dart';
import 'package:asm_app/widget/show_title.dart';
import 'package:flutter/material.dart';

class MyDialog {
  Future<Null> showProgressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image1),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().h3Style()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }
}
