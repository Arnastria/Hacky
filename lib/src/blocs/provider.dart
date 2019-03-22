import 'package:flutter/material.dart';
import 'package:hacky/src/blocs/newsBloc.dart';

class BlocProvider<T> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T>(BuildContext context){
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<NewsBloc>>{
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}