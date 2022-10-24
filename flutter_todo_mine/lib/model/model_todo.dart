import 'package:get/get.dart';

class RxTodoModel {
  final id = 0.obs;
  final name = 'name'.obs;
  final start = 'start-time'.obs;
  final end = 'end-time'.obs;
}

class TodoModel {
  TodoModel({id, name,start, end});

  final rx = RxTodoModel();

  get name => rx.name.value;
  set name(value) => rx.name.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  get start => rx.start.value;
  set start(value) => rx.start.value = value;

  get end => rx.end.value;
  set end(value) => rx.end.value = value;

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'name' : name, 'id':id,
  };
}
