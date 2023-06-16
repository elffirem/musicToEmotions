import 'dart:convert';
import 'package:http/http.dart' as http;

class MoodService {
  Future<String> getMood(String lyrics) async {
    var response = await http.post(
      Uri.parse('http://192.168.1.60:5000/predict'),
      body: jsonEncode({'lyrics': lyrics}),
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
      Uri.parse('http://192.168.1.60:5000/'),
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
