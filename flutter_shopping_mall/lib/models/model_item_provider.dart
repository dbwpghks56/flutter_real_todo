import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model_item.dart';

class ItemProvider with ChangeNotifier {
  late CollectionReference itemReference;
  List<Item> items = [];
  List<Item> searchItems = [];

  ItemProvider({reference}) {
    itemReference = reference ?? FirebaseFirestore.instance.collection('items');
  }

  Future<void> fetchItems() async {
    items = await itemReference.get().then((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot document) {
        return Item.fromSnapShot(document);
      }).toList();
    });

    notifyListeners();
  }

  Future<void> search(String query) async {
    searchItems = [];
    if(query.length == 0) {
      return;
    }
    for(Item item in items) {
      if(item.title.contains(query)) {
        searchItems.add(item);
      }
    }

    notifyListeners();
  }
}