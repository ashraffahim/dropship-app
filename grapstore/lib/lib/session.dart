import 'dart:convert';
import '/env/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Map<String, String> headers = {};
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  get(String url) async {
    final SharedPreferences prefs = await _prefs;
    headers['cookie'] = prefs.getString('cookie') ?? '';
    http.Response response =
        await http.get(Uri.parse(Config.serverAddr + url), headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  post(String url, Map data) async {
    final SharedPreferences prefs = await _prefs;
    headers['cookie'] = prefs.getString('cookie') ?? '';
    http.Response response = await http.post(
      Uri.parse(Config.serverAddr + url),
      body: data,
      headers: headers,
    );
    updateCookie(response);
    return json.decode(response.body);
  }

  void updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
      final SharedPreferences prefs = await _prefs;
      prefs.setString('cookie', headers['cookie'].toString());
    }
  }
}
