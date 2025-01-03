import 'package:flutter/material.dart';
import 'book_registration_screen.dart'; // BookRegistrationScreenをインポート

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('書籍リスト'),
      ),
      body: const Center(
        child: Text('書籍リスト画面'), // 必要に応じて変更
      ),
      floatingActionButton: FloatingActionButton(
        // FloatingActionButtonを追加
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BookRegistrationScreen()),
          );
        },
        child: const Icon(Icons.add), // ボタンのアイコン
        tooltip: '書籍を登録', // 長押しした時に表示されるツールチップ
      ),
    );
  }
}
