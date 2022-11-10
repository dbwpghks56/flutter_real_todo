import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_event.dart';
import 'package:flutter_real_todo/screens/screen_main.dart';
import 'package:flutter_real_todo/tab/tab_calender.dart';
import 'package:flutter_real_todo/tab/tab_my_page.dart';
import 'package:flutter_real_todo/tab/tab_search_user.dart';
import 'package:get/get.dart';
import '../controller/controller_user.dart';

class ScreenTab extends StatefulWidget {
  @override
  _ScreenTabState createState() => _ScreenTabState();
}

class _ScreenTabState extends State<ScreenTab> {
  int _currentIndex = 0;
  final userController = Get.put(UserController());
  final eventController = Get.put(MyController());
  bool appzonzae = true;
  final List<Widget> _tabs = [
    ScreenMain(),
    TabCalender(),
    TabSearchUser(),
    TabMyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appzonzae ? AppBar(
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
      ) : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.blueGrey,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 1 ) {
              appzonzae = false;
            }
            else if(_currentIndex == 2) {
              Get.to(() => TabSearchUser());
            }
            else {
              appzonzae = true;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions_outlined), label: "Todo"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: "calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "myPage"),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
