import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'screens/book_list_screen.dart'; // リスト画面のimport

void main() {
  Logger.root.level = Level.ALL; // 全てのログレベルを有効にする（本番環境では調整が必要）
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: ${record.level.name}: ${record.loggerName}: ${record.message}');
  });
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
