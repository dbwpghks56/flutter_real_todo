import 'package:get/get.dart';

class RxExerciseModel {
  final exid = 0.obs;
  final exName = "".obs;
  final setNo = 0.obs;
  final part = "back".obs;
  final totalNo = 0.obs;
  final setPerNo = 0.obs;
  final breakTime = 0.obs;
  final exDate = DateTime.now().obs;
}

class ExerciseModel {
  ExerciseModel({id, name});

  final rx = RxExerciseModel();

  get exid => rx.exid.value;
  set exid(value) => rx.exid.value = value;

  get exName => rx.exName.value.toString();
  set exName(value) => rx.exName.value = value;

  get setNo => rx.setNo.value;
  set setNo(value) => rx.setNo.value = value;

  get part => rx.part.value;
  set part(value) => rx.part.value = value;

  get totalNo => rx.totalNo.value;
  set totalNo(value) => rx.totalNo.value = value;

  get setPerNo => rx.setPerNo.value;
  set setPerNo(value) => rx.setPerNo.value = value;

  get breakTime => rx.breakTime.value;
  set breakTime(value) => rx.breakTime.value = value;

  get exDate => rx.exDate.value;
  set exDate(value) => rx.exDate.value = value;

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    exid = json['exid'];
    exName = json['exName'];
    setNo = json['setNo'];
    part = json['part'];
    totalNo = json['totalNo'];
    setPerNo = json['setPerNo'];
    breakTime = json['breakTime'];
    exDate = json['exDate'];
  }

  Map<String, dynamic> toJson() => {
    'exName' : exName,
    'setNo' : setNo,
    'part' : part,
    'totalNo' : totalNo,
    'setPerNo' : setPerNo,
    'breakTime' : breakTime,
  };
}
