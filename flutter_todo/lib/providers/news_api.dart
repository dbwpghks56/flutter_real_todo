import 'dart:convert';
import '../models/news.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  static String apiUri = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=";
  static String apiKey = "18e5c4379a514ba6a6e4a82866c5747f";

  Uri uri = Uri.parse(apiUri + apiKey);

  Future<List<News>> getNews() async {
    List<News> newss = [];
    final response = await http.get(uri);
    final statusCode = response.statusCode;
    final body = response.body;

    if(statusCode == 200) {
      newss = jsonDecode(body)['articles'].map<News>((article) {
        return News.fromMap(article);
      }).toList();
    }

    return newss;
  }
}