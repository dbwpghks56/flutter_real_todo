import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ImageWidgetApp();
  }
}

class _ImageWidgetApp extends State<ImageWidgetApp> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Widget'),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/flutter.png', width: 200, height: 100, fit: BoxFit.scaleDown,),
              Text('Hello Flutter', style: TextStyle(fontFamily: 'Pacifico', fontSize: 30, color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}