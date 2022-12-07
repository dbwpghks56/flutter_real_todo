import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  String tag = "";

  Tag({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 25,
        decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              color: const Color(0xff290FBA),
            ),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("#$tag", style: const TextStyle(color: Colors.black,)),
            ],
          ),
        )
    );
  }
}
