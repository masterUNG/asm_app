import 'dart:convert';
import 'package:asm_app/models/home_model.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  static Future<List<HomeModel>> getHomeSuggestions(String query) async {
    final url = Uri.parse('http://aorsormor.online/asmApp_Api/getAllHome.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List homeId = json.decode(response.body);
      return homeId.map((json) => HomeModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
