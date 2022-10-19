import '../models/todo.dart';

class TodoDefault {
  List<Todo> dummyTodo = [
    Todo(id: 1, title: "고양이 만지기", description: "고양이 뽕주딩 쓰다듬기"),
    Todo(id: 2, title: "고양이 밥 주기", description: "고양이 맛동산 캐기"),
    Todo(id: 3, title: "고양이 씻기기", description: "고양이 운동시키기"),
    Todo(id: 4, title: "고양이 마구 만지기", description: "고양이 마구 밥 주기"),
  ];

  List<Todo> getTodos() {
    return dummyTodo;
  }

  Todo getTodo(int id) {
    return dummyTodo[id];
  }

  Todo addTodo(Todo todo) {
    Todo newtodo = new Todo(id: dummyTodo.length + 1,title: todo.title, description: todo.description);
    dummyTodo.add(newtodo);
    return newtodo;
  }

  void deleteTodo(int id) {
    for(var i = 0; i < dummyTodo.length; i++) {
      if(dummyTodo[i].id == id) {
        dummyTodo.removeAt(i);
      }
    }
  }

  void updateTodo(Todo todo) {
    for(var i = 0; i < dummyTodo.length; i++) {
      if(dummyTodo[i].id == todo.id) {
        dummyTodo[i] = todo;
      }
    }
  }

}