import 'package:flutter/material.dart';
import 'package:hacky/src/screens/favoriteScreen.dart';
import 'package:hacky/src/models/newsModel.dart';
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
    ScrollController _scrollController = ScrollController();
    Widget newsList() {
      return StreamBuilder<List<NewsModel>>(
          stream: _bloc.newsModelStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data.length,
//                  separatorBuilder: (context,index){
//                    return Divider(color: Colors.black87);
//                  },
                  itemBuilder: (context, index) {
                    if(index == snapshot.data.length-1){
                      _bloc.updateNews(index);
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      child: NewsArticle(news: snapshot.data[index],favorite: false));
                  });
            }
            return Center(child: CircularProgressIndicator());
          });
    }

    _bloc = BlocProvider.of<NewsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text("Hacker News"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return FavoriteScreen();
            }));
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child:  Icon(Icons.arrow_upward),
          onPressed: (){
            _scrollController.animateTo(0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          }),
      body: Center(
        child: newsList(),
      ),
    );
  }
}
