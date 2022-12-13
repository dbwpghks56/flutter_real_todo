import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitRow extends StatelessWidget {
  final submitFunc;

  SubmitRow({required this.submitFunc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: const Text("cancel"),
        ),
        const Padding(padding: EdgeInsets.only(right: 10)),
        ElevatedButton(
          onPressed: submitFunc,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text("save"),
        ),
        const Padding(padding: EdgeInsets.only(right: 10)),
      ],
    );
  }
}
