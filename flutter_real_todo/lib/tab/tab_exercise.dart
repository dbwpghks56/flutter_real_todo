import 'package:flutter/material.dart';
import 'package:flutter_real_todo/model/model_exercise.dart';
import 'package:flutter_real_todo/util/exercise_pick.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

import '../utils.dart';

class TabExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            ExercisePick(),
          );
        },
        child: const Text("+", style: TextStyle(fontSize: 25),),
      ),
      body: Container(
        child: TableCalendar<RxExerciseModel>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: DateTime.now(),
          locale: 'ko-KR',
          calendarFormat: CalendarFormat.week,
          headerStyle: const HeaderStyle(
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
            ),
            headerMargin: EdgeInsets.only(bottom: 10),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,),
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffB1B2FF),
              border: Border.all(color: const Color(0xffB1B2FF), width: 1.5),
            ),
            holidayTextStyle: const TextStyle(color: Colors.red),
            defaultTextStyle: const TextStyle(color: Colors.black),
            weekendTextStyle: const TextStyle(color: Colors.red),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffD3CEDF),
              border: Border.all(color: const Color(0xffD3CEDF), width: 1.5),
            ),
            canMarkersOverflow: true,
            markerDecoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigoAccent,
                  Color(0xff49a09d)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
