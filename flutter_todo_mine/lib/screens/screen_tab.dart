import 'package:flutter/material.dart';
import 'package:flutter_todo_mine/screens/screen_main.dart';
import 'package:flutter_todo_mine/tab/tab_calender.dart';
import 'package:get/get.dart';
import '../controller/controller_user.dart';

class ScreenTab extends StatefulWidget {
  @override
  _ScreenTabState createState() => _ScreenTabState();
}

class _ScreenTabState extends State<ScreenTab> {
  int _currentIndex = 0;
  final userController = Get.put(UserController());

  final List<Widget> _tabs = [
    ScreenMain(),
    TabCalender()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("멋쟁이 todo"),
        actions: [
          SizedBox(
            width: 100,
            child: InkWell(
              child: const Icon(Icons.logout),
              onTap: () {
                userController.logout();
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.blueGrey,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions_outlined), label: "Todo"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: "calendar"),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
