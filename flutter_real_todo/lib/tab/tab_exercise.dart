import 'package:flutter/material.dart';
import 'package:flutter_real_todo/util/exercise_pick.dart';
import 'package:get/get.dart';

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
      body: Container(),
    );
  }
}
