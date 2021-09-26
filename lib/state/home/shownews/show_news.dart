import 'dart:convert';

import 'package:asm_app/models/news_model.dart';
import 'package:asm_app/utility/my_constant.dart';
import 'package:asm_app/widget/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowNews extends StatefulWidget {
  const ShowNews({Key? key}) : super(key: key);

  @override
  _ShowNewsState createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  List<NewsModel> newsModels = [];
  bool load = true;
  String? pic;

  @override
  void initState() {
    super.initState();
    showNewsFromServer();
  }

  Future<Null> showNewsFromServer() async {
    if (newsModels.length != 0) {
      newsModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? data = preferences.getStringList('data');
    String newsid = data![0];
    String apiShowNews =
        '${MyConstant.domain}/asmApp_Api/show_news.php?isAdd=true&newsid=$newsid';

    await Dio().get(apiShowNews).then((value) {
      load = false;
      for (var item in json.decode(value.data)) {
        NewsModel model = NewsModel.fromMap(item);
        setState(() {
          newsModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'กระดานข่าว',
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
      itemCount: newsModels.length,
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
                        newsModels[index].pic,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsModels[index].topic,
                  style: MyConstant().h2Style(),
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    newsModels[index].content,
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

  String creatURL(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> strings = result.split(',');
    String url = '${MyConstant.domain}/asm_api${strings[0]}';
    return url;
  }
}
