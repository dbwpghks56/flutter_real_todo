import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_event.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class MyController extends GetxController {
  final eventModel = Get.put(RxEventModel());
  final userModel = Get.put(UserController());



}