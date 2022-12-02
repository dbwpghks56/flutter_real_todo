import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class ImageController extends GetxController {

  final pickImage = XFile("").obs;

  set obj(value) => pickImage.value = value;
  get obj => pickImage.value;
}