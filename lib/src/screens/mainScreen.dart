import 'package:flutter/material.dart';
import 'package:hacky/src/screens/favoriteScreen.dart';
import 'package:hacky/src/services/hackyService.dart';
import 'package:hacky/src/screens/newsArticle.dart';
import 'package:hacky/src/blocs/newsBloc.dart';
import 'package:hacky/src/blocs/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NewsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    Widget newsList() {
      return StreamBuilder<List<NewsModel>>(
          stream: _bloc.newsModelStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: NewsArticle(news: snapshot.data[index]));
                  });
            }
            return Center(child: LinearProgressIndicator());
          });
    }

    _bloc = BlocProvider.of<NewsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hacky"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return FavoriteScreen();
            }));
          })
        ],
      ),
      body: Center(
        child: newsList(),
      ),
    );
  }
}
