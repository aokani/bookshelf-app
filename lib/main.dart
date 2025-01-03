import 'package:flutter/material.dart';
import 'screens/list.dart'; // リスト画面のimport

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bookshelf App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookListScreen(), // 最初に表示する画面を指定
    );
  }
}
