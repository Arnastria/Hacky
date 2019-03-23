import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hacky/src/models/newsModel.dart';

String base = "https://hacker-news.firebaseio.com/v0";

Future<List<int>> fetchTopStoriesID()async{
  final response = await http.get('$base/topstories.json');
  List<int> responseList = [];
  for(var i in jsonDecode(response.body)){
    responseList.add(i);
  }
  print(responseList);
  return responseList.toList();
}

Future<NewsModel> fetchNewsData(int id) async{
  final response = await http.get('$base/item/$id.json');
  Map<String,dynamic> responseMap = jsonDecode(response.body);
  String title = responseMap['title'];
  String author = responseMap['by'];
  DateTime time = DateTime.fromMillisecondsSinceEpoch(responseMap['time']*1000);

  return NewsModel(
    id: id,
    title: title,
    author: author,
    dateTime: time
  );
}


