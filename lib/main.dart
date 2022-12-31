import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/splash_screen.dart';
import 'package:flutter_todo_list/screens/login_screen.dart';
import 'package:flutter_todo_list/screens/list_screen.dart';
import 'package:flutter_todo_list/screens/news_screen.dart.';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: SplashScreen(),
    );
  }
}