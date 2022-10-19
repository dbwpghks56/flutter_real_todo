import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:flutter_shopping_mall/tabs/tab_cart.dart';
import 'package:flutter_shopping_mall/tabs/tab_home.dart';
import 'package:flutter_shopping_mall/tabs/tab_profile.dart';
import 'package:flutter_shopping_mall/tabs/tab_search.dart';
import 'package:provider/provider.dart';

class ScreenIndex extends StatefulWidget {
  @override
  _ScreenIndexState createState() => _ScreenIndexState();
}

class _ScreenIndexState extends State<ScreenIndex> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    TabHome(),
    TabCart(),
    TabSearch(),
    TabProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Shopping Mall"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if(index == 2) {
            setState(() {
              _currentIndex = 0;
            });
            Navigator.pushNamed(context, '/search');
          }
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart), label: '장바구니'),
          BottomNavigationBarItem(icon: const Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: '프로필'),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}














