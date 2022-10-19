import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_mall/models/model_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail
}

class FirebaseAuthProvider extends ChangeNotifier {
  FirebaseAuth authClient;
  User? user;

  FirebaseAuthProvider({auth}) : authClient = auth ?? FirebaseAuth.instance;

  Future<AuthStatus> registerWithEmail(String email, String password) async {
    try {
      var url = Uri.parse("http://localhost:8080/user/signUp");
      int success = 0;
      await http.post(url, headers: {
        "Content-Type" : "application/json"
      },body: json.encode({
        "uuid" : email,
        "upassword" : password
      })).then((value) async {
        success = value.statusCode.toInt();
      });

      if(success == 200) {
        return AuthStatus.registerSuccess;
      } else {
        return AuthStatus.registerFail;
      }
    } catch(e) {
      print(e);
      return AuthStatus.registerFail;
    }
  }

  Future<AuthStatus> loginWithEmail(String email, String password) async {
    try {
      var url = Uri.parse("http://localhost:8080/user/login");
      int success = 0;
      await http.post(url, headers: {
        "Content-Type" : "application/json"
      },body: json.encode({
        "uuid" : email,
        "upassword" : password
      })).then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        print(value.body);
        success = value.statusCode.toInt();
        prefs.setString('email', json.decode(value.body)["id"].toString());
        prefs.setString('password', json.decode(value.body)["password"].toString());
      });

      if(success == 200) {
        return AuthStatus.loginSuccess;
      } else {
        return AuthStatus.loginFail;
      }
    } catch(e) {
      print(e);
      return AuthStatus.loginFail;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('email', '');
    prefs.setString('password', '');
    user = null;
    await authClient.signOut();
    print('[-] 로그아웃');
  }
}