import 'package:flutter/material.dart';

class CountScreen extends StatefulWidget {
  _CountScreenState createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  int count = 0;

  void decrease() {
    setState(() {
      count -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카운터 앱"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("카운트 : $count", style: TextStyle(fontSize: 25),),
            Padding(padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {setState(() {
                  count += 1;
                });}, child: Text("+ 증가")),
                ElevatedButton(onPressed: decrease, child: Text("- 감소")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}