/// Generated by Flutter GetX Starter on 2022-10-21 09:47

import 'package:flutter/material.dart';
import 'package:flutter_real_todo/screens/screen_login.dart';
import 'package:flutter_real_todo/screens/screen_splash.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ScreenSplash(),
    );
  }
}