import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_todo/util/exercise_enum.dart';
import 'package:get/get.dart';

class ExercisePick extends StatelessWidget {
  final _type = ExerciseType.back.obs;
  final setNo = TextEditingController();

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
                  Container(
                    width: 60,
                    height: 50,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextField(
                      controller: setNo,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Set.No",
                        label: Text("Set 수 기록"),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                  ),
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
