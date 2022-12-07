import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  String tag = "";
  Color? textColor = Colors.black;

  Tag({required this.tag, this.textColor});

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
            // color: Colors.white,
            // boxShadow: const [BoxShadow(
            //   color: Color(0xff290FBA),
            //   spreadRadius: 0.5,
            //   blurRadius: 0.5,
            //   offset: Offset(0, 1),
            // )],
            borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("#$tag", style: TextStyle(color: textColor,)),
            ],
          ),
        )
    );
  }
}
