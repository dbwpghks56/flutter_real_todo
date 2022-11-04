// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:flutter_real_todo/model/model_event.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

RxEventModel eventModel = Get.put(RxEventModel());

/// Example event class.
class Event {
  final String title;
  final bool complete;
  const Event(this.title, this.complete);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in eventModel.events)
    DateTime.parse(item["eventEnd"]) : [Event(item["eventName"], item["eventClear"] == 0 ? false : true)]
};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);