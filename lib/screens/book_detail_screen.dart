import 'package:flutter/material.dart';
import '../book.dart'; // Bookクラスをインポート

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title), // bookオブジェクトからタイトルを取得
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('著者: ${book.author}', style: const TextStyle(fontSize: 16)),
            Text('出版社: ${book.publisher}', style: const TextStyle(fontSize: 16)),
            // 他の情報を表示
          ],
        ),
      ),
    );
  }
}
