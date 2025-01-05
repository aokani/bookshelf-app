import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/book_list_model.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookListModel()), // BookListModelを提供
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookListScreen(), // 初期画面
    );
  }
}
