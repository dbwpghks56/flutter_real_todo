import 'package:get/get.dart';

class RxEventModel {
  final eventName = 'name'.obs;
  final eventStart = DateTime(2022,11,30).obs;
  final eventEnd = DateTime(2022,11,30).obs;
}

class EventModel {
  EventModel({name});

  final rx = RxEventModel();

  get eventName => rx.eventName.value;
  set eventName(value) => rx.eventName.value = value;

  get eventStart => rx.eventStart.value;
  set eventStart(value) => rx.eventStart.value = value;

  get eventEnd => rx.eventEnd.value;
  set eventEnd(value) => rx.eventEnd.value = value;

  EventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'name' : eventName,
  };
}
