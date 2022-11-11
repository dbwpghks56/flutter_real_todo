import 'package:get/get.dart';

class RxUsersModel {
  final users = [].obs;
}

class UsersModel {
  UsersModel({users});

  final rx = RxUsersModel();

  get users => rx.users;
  set users(value) => rx.users.value = value;

}
