import 'package:flutter/material.dart';
import 'package:hacky/src/screens/mainScreen.dart';

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MainScreen(),
    );
  }
}