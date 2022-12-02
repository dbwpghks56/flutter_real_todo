import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/image_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  @override
  ImagePickState createState() => ImagePickState();
}

class ImagePickState extends State<ImagePick> {
  final ImagePicker _picker = ImagePicker();
  final imageService = Get.put(ImageController());


  Future<void> _pickImg() async {
    XFile? pick = await _picker.pickImage(source: ImageSource.gallery);
    imageService.pickImage(pick);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _pickImg();
      },
      child:Obx(() {
        return Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(110),
            border: Border.all(
                style: BorderStyle.solid,
                color: Colors.indigoAccent
            ),
            image: imageService.pickImage.value.path != "" ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageService.pickImage.value.path))
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageService.pickImage.value.path == "" ? const Text("사진을 넣어주세요.") : Container(),
              ],
            ),
          ),
        );
      })
    );
  }
}
