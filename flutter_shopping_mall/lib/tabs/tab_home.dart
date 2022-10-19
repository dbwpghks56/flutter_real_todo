import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/model_item_provider.dart';

class TabHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    Future<void> callItems() async {
      final url = Uri.parse("http://localhost:8080/item/getItems");
      var response = await http.get(url);
      response.body;
    }

    return FutureBuilder(
      future: itemProvider.fetchItems(),
      builder: (context, snapshot) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.5,
                ),
                itemCount: itemProvider.items.length,
                itemBuilder: (context, index) {
                  return GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: itemProvider.items[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(itemProvider.items[index]["imageUrl"], width: 500,
                                height: 600,),
                              Text(
                                itemProvider.items[index]["title"].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text('${itemProvider.items[index]["price"].toString()}원',
                                style: const TextStyle(fontSize: 16, color: Colors.red),),
                            ],
                          ),
                        ),
                      )
                  );
                }
            );
      },
    );
  }
}
