import 'dart:convert';
import 'package:http/http.dart' as http;

class MoodService {
  static const String baseUrl = "http://192.168.1.102:5000/";
  Future<String> getMood(String songName, String artistName) async {
    var response = await http.post(
      Uri.parse("${baseUrl}predict"),
      body: jsonEncode({'songName': songName, 'artistName': artistName}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print("Success");
      var data = jsonDecode(response.body);
      return data['mood'];
    } else {
      throw Exception('Failed to get mood');
    }
  }

  Future<String> getMoodTest() async {
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print("Success");
      var data = jsonDecode(response.body);
      return data['mood'];
    } else {
      throw Exception('Failed to get mood');
    }
  }
}
