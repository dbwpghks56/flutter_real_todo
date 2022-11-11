import 'package:flutter/material.dart';

class TabSearchUser extends StatelessWidget {

  final searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 290,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 5.0),
                child : TextField(
                  controller: searchText,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "검색할 유저를 입력해주세요."
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
