import 'package:flutter/material.dart';
import 'item.dart';

class Cart extends ChangeNotifier {
  final List<Item> items = [];

  int getTotalPrice() {
    int total = 0;
    for(Item item in items) {
      total += item.price;
    }

    return total;
  }

  void addItem(Item item) {
    items.add(item);
    notifyListeners();
  }

  void deleteItem(int id) {
    items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}