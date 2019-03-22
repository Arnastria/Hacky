import 'package:flutter/material.dart';
import 'package:hacky/src/services/hackyService.dart';
import 'package:hacky/src/blocs/newsBloc.dart';
import 'package:hacky/src/blocs/provider.dart';

class NewsArticle extends StatefulWidget {
  final NewsModel news;
  NewsArticle({this.news});

  @override
  _NewsArticleState createState() => _NewsArticleState(news: news);
}

class _NewsArticleState extends State<NewsArticle> {
  final NewsModel news;
  NewsBloc _bloc;
  _NewsArticleState({this.news});

  @override
  Widget build(BuildContext context) {
    Widget NewsTile(NewsModel news) {
      return ListTile(
        onTap: () {
          print("tap $news ${news.id}");
          _bloc.addFavNews(news);
          setState(() {});
        },
        leading: Icon(Icons.phone_android),
        trailing: _bloc.favoriteMap[news.id] ? Icon(Icons.favorite):Icon(Icons.favorite_border) ,
        title: Text(news.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Author: ${news.author}"),
            Text(news.time.toString()),
          ],
        ),
      );
    }

    _bloc = BlocProvider.of<NewsBloc>(context);
    return Container(
      child: NewsTile(news),
    );
  }
}
