import 'package:flutter/material.dart';
import 'package:hacky/src/screens/mainScreen.dart';
import 'package:hacky/src/blocs/newsBloc.dart';
import 'package:hacky/src/blocs/provider.dart';
import 'package:hacky/src/navigator.dart';

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  final _bloc = NewsBloc();
  final GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    Nav.setNavState(_navigatorKey);
    return BlocProvider(
      bloc: _bloc,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        home: MainScreen(),
      ),
    );
  }
}