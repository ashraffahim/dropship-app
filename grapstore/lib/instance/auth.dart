import 'package:flutter/material.dart';
import 'package:grapstore/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/auth.dart';

class Auth extends StatefulWidget {
  final String _tab;

  Auth(this._tab);

  @override
  State<Auth> createState() => AuthState(_tab);
}

class AuthState extends State<Auth> {
  final String _tab;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AuthState(this._tab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tab == 'login' ? Login(this.login) : Signup(),
    );
  }

  Future<void> login(String user, String pass) async {
    final SharedPreferences prefs = await _prefs;
    Map data;

    AuthModel authModel = AuthModel();
    data = await authModel.login(user, pass);

    if (data['status']) {
      List<String> userData = [];
      // ashraf.fahim75@gmail.com

      data['data'].entries.forEach((e) {
        userData.add(e.value.toString());
      });

      prefs.setStringList(
        'user',
        userData,
      );
    } else {
      print('Login Failed! (${data["status"]})');
    }
  }
}
