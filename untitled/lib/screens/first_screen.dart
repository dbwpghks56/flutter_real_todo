import 'package:flutter/material.dart';
import 'package:untitled/screens/second_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is First Screes'),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => SecondScreen(screenData: "Data from FirstScreen",)),
              );
            }, child: Text('Go to Second Screen')),
          ],
        ),
      ),
    );
  }
}