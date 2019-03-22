import 'package:flutter/material.dart';

class Nav {
  static GlobalKey<NavigatorState> _navState;

  static setNavState(navState) {
    _navState = navState;
  }

  static push(String routeName) {
    _navState.currentState.pushNamed(routeName);
  }

  static pop(){
    _navState.currentState.pop();
  }

  static pushMaterialRoute(routeName){
    _navState.currentState.push(routeName);
  }

  static pushReplacementNamed(routeName){
    _navState.currentState.pushReplacementNamed(routeName);
  }

  static pushFullScreenDialog(Widget widget){
    _navState.currentState.push(MaterialPageRoute(
        builder: (context){
          return widget;
        },
        fullscreenDialog: true));
  }

}