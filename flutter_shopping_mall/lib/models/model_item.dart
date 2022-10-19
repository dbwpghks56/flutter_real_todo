import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  late String title;
  late String description;
  late String brand;
  late String imageUrl;
  late String price;
  late String registerDate;
  late String id;

  Item({
    required this.title,
    required this.description,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.registerDate,
    required this.id,
  });

  Item.fromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    title = data['title'];
    description = data['description'];
    brand = data['brand'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    registerDate = data['registerDate'];

  }

  Item.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    description = data['description'];
    brand = data['brand'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    registerDate = data['registerDate'];
  }

  Map<String, dynamic> toSnapShot() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'imageUrl' : imageUrl,
      'brand' : brand,
      'price' : price,
      'registerDate' : registerDate,
    };
  }

}