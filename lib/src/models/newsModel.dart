import 'package:intl/intl.dart';
var formatter = new DateFormat('MMM d, yyyy');

class NewsModel implements Comparable<NewsModel>{
  int id;
  String title;
  String author;
  DateTime dateTime;
  String time;
  NewsModel({this.id, this.title, this.author, this.dateTime}){
    time = formatter.format(dateTime);
  }

  @override
  int compareTo(NewsModel other) {
    return time.compareTo(other.time);
  }
}