import 'package:flutter/material.dart';
import 'package:grapstore/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/auth.dart';

class Auth extends StatefulWidget {
  final String _tab;

  Auth(this._tab);

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AuthModel authModel = AuthModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._tab == 'login'
          ? Login(login)
          : Signup(signup, verify, clear, resend),
    );
  }

  Future<void> login(String user, String pass) async {
    final SharedPreferences prefs = await _prefs;
    Map data;

    data = await authModel.login(user, pass);

    if (data['status'] == 0) {
      List<String> userData = [];
      // ashraf.fahim75@gmail.com

      data['data'].entries.forEach((e) {
        userData.add(e.value.toString());
      });

      prefs.setStringList(
        'user',
        userData,
      );

      // Redirect to previoud page
      Navigator.of(context).pop();
    } else {
      print('Login Failed! (${data["status"]})');
    }
  }

  Future<List> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String country,
      required String password}) async {
    final SharedPreferences prefs = await _prefs;
    Map data;

    data = await authModel.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      country: country,
      password: password,
    );

    switch (data['status']) {
      case 0:
        List<String> userData = [];
        // ashraf.fahim75@gmail.com

        return [0, 'Verification code is sent to your email', Colors.green];
      case 1:
        return [1, 'User already exists. Try loging in', Colors.amber];
      case 2:
        return [2, 'Check email for verification code', Colors.black];
    }

    return [3, 'Unexpected error! Try again', Colors.red];
  }

  Future<List> verify(code) async {
    final SharedPreferences prefs = await _prefs;
    Map data = await authModel.verify(code);

    switch (data['status']) {
      case 0:
        List<String> userData = [];
        // ashraf.fahim75@gmail.com

        data['data'].entries.forEach((e) {
          userData.add(e.value.toString());
        });

        prefs.setStringList(
          'user',
          userData,
        );

        // Redirect to previoud page
        Navigator.of(context).pop();

        return [
          0,
          'Email verified! You can continue to checkout!',
          Colors.green
        ];
      case 1:
        return [1, 'Old code is expired! Check email for new code', Colors.red];
      case 2:
        return [2, 'Wrong verification code', Colors.amber];
    }
    return [3, 'Unexpected error! Please try again', Colors.black];
  }

  Future<int> clear() async {
    Map data = await authModel.clear();
    return data['status'];
  }

  Future<int> resend() async {
    Map data = await authModel.resend();
    return data['status'];
  }
}
