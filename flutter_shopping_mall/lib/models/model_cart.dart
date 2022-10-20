import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model_item.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  late CollectionReference cartReference;
  List<Item> cartItems = [];

  CartProvider({reference}) {
    cartReference = reference ?? FirebaseFirestore.instance.collection('carts');
  }

  Future<void> fetchCartItemsOrAddCart(User? user) async {
    if( user == null ) {
      return;
    }

    final cartSnapShot = await cartReference.doc(user.uid).get();

    if(cartSnapShot.exists) {
      Map<String, dynamic> cartItemsMap = cartSnapShot.data() as Map<String, dynamic>;
      List<Item> temp = [];
      for(var item in cartItemsMap['item']) {
        temp.add(item);
      }
      cartItems = temp;
      notifyListeners();
    } else {
      await cartReference.doc(user.uid).set({'item' : []});
      notifyListeners();
    }
  }

  Future<void> addItemToCart(User? user, int item) async {
    var url = Uri.parse("http://localhost:8080/cart/insertCart");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "users" : prefs.getString("pid"),
          "items" : item
        })
    ).then((value) {

    });
    
    // cartItems.add(item);
    // Map<String, dynamic> cartItemsMap = {
    //   'items' : cartItems.map((e) {
    //     return e.toSnapShot();
    //   }).toList()
    // };
    // await cartReference.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  Future<void> removeItemFromCart(User? user, Item item) async {
    cartItems.removeWhere((element) => element.id == item.id);
    Map<String, dynamic> cartItemsMap = {
      'items' : cartItems.map((e) {
        return e.toSnapShot();
      }).toList()
    };

    await cartReference.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  Future<bool> isItemInCart(int item)  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse("http://localhost:8080/cart/getCart/${prefs.getString("pid")}");
    await http.get(url).then((value) {
      List<dynamic> items = json.decode(value.body);
      for(Item ritem in items) {
        return ritem.id == item;
      }
    });

    return false;
  }

}