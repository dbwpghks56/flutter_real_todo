import 'package:flutter/material.dart';
import 'package:cr_calendar/cr_calendar.dart';

class TabCalender extends StatelessWidget {
  final CrCalendarController _calendarController = CrCalendarController();
  final _currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CrCalendar(
          firstDayOfWeek: WeekDay.monday,
          eventsTopPadding: 32,
          initialDate: _currentDate,
          maxEventLines: 3,
          controller: _calendarController,
          forceSixWeek: true,
          minDate: DateTime.now().subtract(const Duration(days: 1000)),
          maxDate: DateTime.now().add(const Duration(days: 180))
      ),
    );
  }
}
