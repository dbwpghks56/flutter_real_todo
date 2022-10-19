import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/providers/todo_firebase.dart';
import 'news_screen.dart';
import '../providers/todo_sqf.dart';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../providers/todo_default.dart';

class ListScreen extends StatefulWidget {
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  // TodoDefault todoDefault = TodoDefault();
  TodoSqlite todoDefault = TodoSqlite();
  TodoFirebase todoFirebase = TodoFirebase();
  bool isLoading = true;

  // Future initDb() async {
  //   await todoDefault.initDb().then((value) async {
  //     todos = await todoDefault.getTodos();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      todoFirebase.initDb();
    });
    // Timer(Duration(seconds: 2), () {
    //   // todos = todoDefault.getTodos();
    //   initDb().then((_) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:  todoFirebase.todoStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator(),),
            );
          }
          else {
            todos = todoFirebase.getTodos(snapshot);
            return Scaffold(
              appBar: AppBar(
                title: Text("할 일 목록 앱"),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book),
                          Text("뉴스"),
                        ],
                      ),
                    ),
                  ),
                ],
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.backspace),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Text("+", style: TextStyle(fontSize: 25),),
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                    String title = '';
                    String description = '';
                    return AlertDialog(
                      title: Text("할 일 추가하기"),
                      content: Container(
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: InputDecoration(labelText: "제목"),
                            ),
                            TextField(
                              onChanged: (value) {
                                description = value;
                              },
                              decoration: InputDecoration(labelText: "설명"),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () async {
                          // await todoDefault.addTodo(Todo(title: title, description: description));
                          // List<Todo> newTodos = await todoDefault.getTodos();
                          // setState(() {
                          //   print("[UI] ADD");
                          //   // todoDefault.addTodo(Todo(title: title, description: description));
                          //   todos = newTodos;
                          // });
                          Todo newtodo = Todo(title: title, description: description);
                          todoFirebase.addTodo(newtodo).then((value) {
                            Navigator.of(context).pop();
                          });
                        }, child: Text("추가")),
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: Text("취소")),
                      ],
                    );
                  });
                },
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todos[index].title),
                      onTap: () {
                        showDialog(context: context, builder: (BuildContext context) {
                          return SimpleDialog(
                            title: Text("할 일"),
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("제목 : " + todos[index].title),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text("설명 : " + todos[index].description),
                              ),
                            ],
                          );
                        });
                      },
                      trailing: Container(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: InkWell(
                                child: Icon(Icons.edit),
                                onTap: () {
                                  showDialog(context: context, builder: (BuildContext context) {
                                    String title = "";
                                    String description = "";
                                    return AlertDialog(
                                      title: Text("할 일 수정하기"),
                                      content: Container(
                                        height: 400,
                                        child: Column(
                                          children: [
                                            TextField(
                                              onChanged: (value) {
                                                title = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText: todos[index].title,
                                              ),
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                description = value;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: todos[index].description,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(onPressed: () async {
                                          // Todo newTodo = Todo(id: todos[index].id,title: title, description: description);
                                          // await todoDefault.updateTodo(newTodo);
                                          // List<Todo> newTodos = await todoDefault.getTodos();
                                          // setState(() {
                                          //   // todoDefault.updateTodo(newTodo);
                                          //   todos = newTodos;
                                          // });
                                          Todo newtodo = Todo(title: title, description: description, reference: todos[index].reference);
                                          todoFirebase.updateTodo(newtodo).then((value) {
                                            Navigator.of(context).pop();
                                          });
                                        }, child: Text("수정")),
                                        TextButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: Text("취소")),
                                      ],
                                    );
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: InkWell(
                                child: Icon(Icons.delete),
                                onTap: () {
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("할 일 삭제하기"),
                                      content: Text("정말 삭제하시겠습니까?"),
                                      actions: [
                                        TextButton(onPressed: () async {
                                            // await todoDefault.deleteTodo(todos[index].id ?? 0);
                                            // List<Todo> newTodos = await todoDefault.getTodos();
                                            // setState(() {
                                            //   // todoDefault.deleteTodo(todos[index].id ?? 0);
                                            //   todos = newTodos;
                                            // });
                                            todoFirebase.deleteTodo(todos[index]).then((value) {
                                              Navigator.of(context).pop();
                                            });
                                        }, child: Text("삭제")),
                                        TextButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: Text("취소")),
                                      ],
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, separatorBuilder: (context, index) {
                    return Divider();
              }, itemCount: todos.length)
            );}
    });
  }
}