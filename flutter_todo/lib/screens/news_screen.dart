import 'package:flutter/material.dart';
import 'package:flutter_todo/providers/news_api.dart';
import '../models/news.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsStateScreen createState() => _NewsStateScreen();
}

class _NewsStateScreen extends State<NewsScreen> {
  NewsApi newsApi = NewsApi();
  List<News> newss = [];
  bool isLoading = true;

  Future initNews() async {
    newss = await newsApi.getNews();
  }

  @override
  void initState() {
    super.initState();
    initNews().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("뉴스화면"),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_backspace),
                Text("뒤로"),
              ],
            ),
          ),
        ),
      ),
      body: isLoading ? Center(child:  const CircularProgressIndicator(),)
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: newss.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    newss[index].title,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    newss[index].description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }),
    );
  }
}