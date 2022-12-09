import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_real_todo/util/exercise_enum.dart';
import 'package:get/get.dart';

class ExercisePick extends StatelessWidget {
  final _type = ExerciseType.back.obs;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 350,
        height: 600,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: ExerciseType.values.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return RadioListTile(
                        value: ExerciseType.values[index],
                        title: Text(ExerciseType.values[index].toString().split(".")[1]),
                        groupValue: _type.value,
                        onChanged: (ExerciseType? value) {
                          _type(value!);
                          print(_type);
                        }
                    );
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                ],
              ),
              SizedBox(

              ),
              SizedBox(

              ),
              SizedBox(

              ),
            ],
          ),
      ),
    );
  }
}
