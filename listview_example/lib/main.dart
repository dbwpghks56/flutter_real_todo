import 'package:flutter/material.dart';
import 'sub/fistPage.dart';
import 'sub/secondPage.dart';
import './animalItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Animal> animalList = new List.empty(growable: true);

  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(
        animalName: "공룍", kind: "공룡", imagePath: "repo/images/daino.png"));
    animalList.add(Animal(
        animalName: "어항", kind: "물고기", imagePath: "repo/images/fish.png"));
    animalList.add(Animal(
        animalName: "토꺵이", kind: "토끼", imagePath: "repo/images/bunny.png"));
    animalList.add(Animal(
        animalName: "라노티", kind: "티라노", imagePath: "repo/images/tirano.png"));
    animalList.add(Animal(
        animalName: "아우우", kind: "늑대", imagePath: "repo/images/wolf.png"));
    animalList.add(Animal(
        animalName: "코로나", kind: "박쥐", imagePath: "repo/images/bat.png"));
  }

  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView example'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(
            list: animalList,
          ),
          SecondApp()
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(
              Icons.looks_one,
              color: Colors.blueAccent,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.looks_two,
              color: Colors.cyan,
            ),
          )
        ],
        controller: controller,
      ),
    );
  }
}
