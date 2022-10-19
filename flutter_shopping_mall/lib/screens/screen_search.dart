import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:flutter_shopping_mall/models/model_query.dart';
import 'package:provider/provider.dart';

class ScreenSearch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final searchQuery = Provider.of<SearchQuery>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            TextField(
              onChanged: (text) {
                searchQuery.updateText(text);
                itemProvider.search(text);
              },
              autofocus: true,
              decoration: const InputDecoration(
                hintText: '검색어를 입력하세요.',
                border: InputBorder.none
              ),
              maxLines: 1,
              cursorColor: Colors.blueGrey,
              cursorWidth: 1.5,
            )
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {
            itemProvider.search(searchQuery.text);
          }, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: itemProvider.searchItems[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(itemProvider.searchItems[index].imageUrl, width: 500, height: 600,),
                              Text(itemProvider.searchItems[index].title,
                              style: const TextStyle(fontSize: 18),),
                              Text('${itemProvider.searchItems[index].price}원' ,
                              style: const TextStyle(fontSize: 16, color: Colors.red),),
                            ],
                          ),
                        ),
                      )
                  );
                },
                itemCount: itemProvider.searchItems.length,
              ),
          ),
        ],
      ),
    );
  }
}
