import 'package:get/get.dart';

class RxEventModel {
  final eventName = 'name'.obs;
  final eventStart = DateTime(2022,11,30).obs;
  final eventEnd = DateTime(2022,11,30).obs;
  final eventClear = 0.obs;
  final events = [].obs;
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

  get eventClear => rx.eventClear.value;
  set eventClear(value) => rx.eventClear.value = value;

  get events => rx.events.value;
  set events(value) => rx.events.value = value;

  EventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    eventClear = json["eventClear"];
    eventStart = json["eventStart"];
    eventEnd = json["eventEnd"];
  }

  Map<String, dynamic> toJson() => {
    'name' : eventName,
  };
}
