import 'dart:convert';

import 'package:asm_app/models/know_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowKnow extends StatefulWidget {
  const ShowKnow({Key? key}) : super(key: key);

  @override
  _ShowKnowState createState() => _ShowKnowState();
}

class _ShowKnowState extends State<ShowKnow> {
  List<KnowModel> knowModels = [];
  bool load = true;

  @override
  void initState() {
    super.initState();
    showKnowFromServer();
  }

  Future<Null> showKnowFromServer() async {
    if (knowModels.length != 0) {
      knowModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    String knowid = data![0];
    String apiShowKnows =
        '${MyConstant.domain}/asmApp_Api/show_know.php?isAdd=true&knowid=$knowid';

    await Dio().get(apiShowKnows).then((value) {
      load = false;
      for (var item in json.decode(value.data)) {
        KnowModel model = KnowModel.fromMap(item);
        setState(() {
          knowModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'คลังความรู้',
            style: MyConstant().textWidget2(),
          ),
          backgroundColor: MyConstant.primary,
        ),
        body: load
            ? ShowProgress()
            : LayoutBuilder(
                builder: (context, constraints) => buildListView(constraints),
              ));
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: knowModels.length,
      itemBuilder: (context, index) => Card(
        color: Colors.grey.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.network(
                    "http://aorsormor.online/aorsormor/" +
                        knowModels[index].pic,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  knowModels[index].title,
                  style: MyConstant().h2Style(),
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    knowModels[index].content,
                    style: MyConstant().h3Style(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
