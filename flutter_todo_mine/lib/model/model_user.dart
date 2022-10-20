import 'package:get/get.dart';

class User extends GetxController {
  final email = "".obs;
  final password = "".obs;
  final passwordConfirm = "".obs;

  void emailChange(String text) {
    email.value = text;
    update();
  }
}