import 'package:flutter/material.dart';
import 'detail.dart'; // 詳細画面のimport

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('書籍リスト'),
      ),
      body: Center(
        child: ElevatedButton(
          // ボタンを追加
          onPressed: () {
            Navigator.push(
              // 画面遷移
              context,
              MaterialPageRoute(builder: (context) => const BookDetailScreen()),
            );
          },
          child: const Text('詳細画面へ'),
        ),
      ),
    );
  }
}
