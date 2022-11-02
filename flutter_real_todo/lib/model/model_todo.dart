import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RxTodoModel {
  final id = 0.obs;
  final name = 'name'.obs;
  final start = 'start-time'.obs;
  final end = 'end-time'.obs;
  final durationTime = 0.obs;
  final todos = [].obs;
  final tabColor = 0.obs;
}

class TodoModel {
  TodoModel({id, name,start, end, todos});

  final rx = RxTodoModel();

  get name => rx.name.value;
  set name(value) => rx.name.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  get start => rx.start.value;
  set start(value) => rx.start.value = value;

  get end => rx.end.value;
  set end(value) => rx.end.value = value;

  get todos => rx.todos.value;
  set todos(value) => rx.todos.value = value;

  get durationTime => rx.durationTime.value;
  set durationTime(value) => rx.durationTime.value = value;

  get tabColor => rx.tabColor.value;
  set tabColor(value) => rx.tabColor.value = value;


  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'todoName' : name, 'startTime' : start, 'endTime' : end
  };
}
