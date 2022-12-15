import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_real_todo/controller/controller_exercise.dart';
import 'package:flutter_real_todo/controller/controller_user.dart';
import 'package:flutter_real_todo/model/model_exercise.dart';
import 'package:flutter_real_todo/util/exercise_enum.dart';
import 'package:flutter_real_todo/util/submit_row.dart';
import 'package:get/get.dart';

class ExercisePick extends StatelessWidget {
  final _type = ExerciseType.back.obs;
  final _partType = [
    ExerciseType.back,
    ExerciseType.chest,
    ExerciseType.shoulder,
    ExerciseType.arm,
    ExerciseType.abs,
    ExerciseType.leg
  ];
  final _accoflag = 0.obs;
  final exerciseModel = Get.put(ExerciseModel());
  final userModel = Get.put(UserController());
  final exerciseController = Get.put(ExerciseController());
  final setNo = TextEditingController();
  final exerName = TextEditingController();
  final setPerNo = TextEditingController();
  final setPerRest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 350,
        height: 600,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Obx(() {
              //   return ExpansionPanelList(
              //     expansionCallback: (panelIndex, isExpanded) {
              //       _accoflag[panelIndex] = !_accoflag[panelIndex];
              //     },
              //     children: [
              //       ExpansionPanel(
              //           isExpanded: _accoflag[0],
              //           headerBuilder: (context, isExpanded) {
              //             return Text("test");
              //           },
              //           body: Text("test")
              //       ),
              //     ],
              //   );
              // }),
              SizedBox(
              width: 330,
              height: 220,
              child: GridView.builder(
                itemCount: _partType.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Obx(() {
                    return ChoiceChip(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xffDAEAF1),
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.indigoAccent
                        ),
                      ),
                      label: Text(
                        _partType[index].toString().split(".")[1].toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      selected: _accoflag.value == index,
                      onSelected: (value) {
                        _accoflag.value = (value ? index : null)!;
                        exerciseModel.part = _partType[_accoflag.value].toString().split(".")[1];
                      },
                    );
                  });
                },
              )),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: ExerciseType.values.length,
              //   itemBuilder: (context, index) {
              //     return Obx(() {
              //       return RadioListTile(
              //           value: ExerciseType.values[index],
              //           title: Text(ExerciseType.values[index].toString().split(".")[1]),
              //           groupValue: _type.value,
              //           onChanged: (ExerciseType? value) {
              //             _type(value!);
              //             exerciseModel.part = value.toString().split(".")[1];
              //             print(exerciseModel.part);
              //           }
              //       );
              //     });
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 50,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextField(
                      controller: exerName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "운동 이름",
                      ),
                    ),
                  ),
                  Container(
                    width: 90,
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
                         hintText: "Set 수 기록",
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 50,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextField(
                      controller: setPerNo,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Set 당 횟수",
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: TextField(
                  controller: setPerRest,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Set 당 쉬는 시간 : 단위 Sec",
                  ),
                  textAlign: TextAlign.right,
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
              SubmitRow(
                submitFunc: () async {
                  exerciseModel.exName = exerName.text;
                  exerciseModel.setNo = int.parse(setNo.text);
                  exerciseModel.setPerNo = int.parse(setPerNo.text);
                  exerciseModel.breakTime = int.parse(setPerRest.text);
                  await exerciseController.insertExercises();
                }
              ),
            ],
          ),
      ),
    );
  }
}
