import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/model_exercise.dart';
import 'exercise_enum.dart';

class ChipTile extends StatelessWidget {
  double sizeChipWidth = 0;
  double sizeChipHeight = 0;
  int chipGridCount = 0;

  ChipTile({required this.sizeChipHeight, required this.sizeChipWidth, required this.chipGridCount});

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: sizeChipWidth,
        height: sizeChipHeight,
        child: GridView.builder(
          itemCount: _partType.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: chipGridCount,
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
        ));
  }
}
