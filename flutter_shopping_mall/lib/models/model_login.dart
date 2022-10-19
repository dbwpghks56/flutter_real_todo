import 'package:flutter/material.dart';

class LoginFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";

  LoginFieldModel();

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }


  LoginFieldModel.fromMap(Map<String, dynamic> data) {
    email = data["id"];
    password = data["password"];
  }
}